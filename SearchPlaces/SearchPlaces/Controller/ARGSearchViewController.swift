//
//  ARGSearchViewController.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import UIKit

class ARGSearchViewController: UITableViewController, ARGAlertable, ARGActivityIndicatorProtocol {
    var indicatorView: UIView?
    
    @IBOutlet weak var searchBar: UISearchBar!
    var searchHandler = ARGSearchHandler()
    var datasource = ARGSearchResultsDatasource()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.register(ARGBasicCell.self, forCellReuseIdentifier: ARGBasicCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension ARGSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let result = searchHandler.search(text: searchBar.text) { [weak self] data, error in
            self?.hideIndicator()
            if let error = error {
                self?.show(error: error)
            } else if let data = data {
                self?.parseRceived(response: data)
            } else {
                print("unknown response")
            }
        }
        if result {
            showIndicator()
            view.endEditing(true)
        } else {
            print("invalid search text")
        }
    }
    
    func parseRceived(response: Data) {
        do {
            let searchResult = try JSONDecoder().decode(ARGSearchResponse.self, from: response)
            datasource.searchText = searchBar.text ?? ""
            datasource.results = searchResult.results
            tableView.reloadData()
        } catch {
            print("parsing error: \(error)")
        }
    }
}

// MARK: - UITableViewDelegate
extension ARGSearchViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(datasource.height(forSection: section))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.numberOfRows(inSection: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ARGBasicCell.reuseIdentifier) as? ARGBasicCell {
            let title = datasource.titleFor(indexPath: indexPath)
            cell.configure(withTitle: title, showAccessory: datasource.shouldDisplayAccessory)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let mapViewController = storyboard?.instantiateViewController(withIdentifier: ARGMapViewController.storyboardIdentifier) as? ARGMapViewController {
            navigationController?.pushViewController(mapViewController, animated: true)
        }
    }
}
