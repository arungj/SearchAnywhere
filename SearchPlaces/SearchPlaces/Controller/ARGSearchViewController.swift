//
//  ARGSearchViewController.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import UIKit

/**
 This ViewController allows to search for a place and lists the results in a TableView.
 */
class ARGSearchViewController: UITableViewController, ARGAlertable, ARGActivityIndicatorProtocol {
    
    @IBOutlet weak var searchBar: UISearchBar!
    weak var indicatorView: UIView?
    weak var welcomeMessage: UILabel?
    
    var searchHandler = ARGSearchHandler()
    var datasource = ARGSearchResultsDataSource()
    var textTintColor: UIColor?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        title = "Search Places"
        textTintColor = .darkBlue
        
        tableView.register(ARGBasicCell.self, forCellReuseIdentifier: ARGBasicCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        searchBar.tintColor = textTintColor
        refreshScroll()
        showWelcomeMessage()
    }
    
    func refreshScroll() {
        tableView.isScrollEnabled = datasource.shouldScroll
    }
    
    func showWelcomeMessage() {
        let messageLabel = UILabel()
        messageLabel.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        messageLabel.text = "Welcome!!"
        messageLabel.textColor = textTintColor
        view.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        self.welcomeMessage = messageLabel
    }
    
    func removeWelcomeMessage() {
        welcomeMessage?.removeFromSuperview()
    }
}

// MARK: - UISearchBarDelegate
extension ARGSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        removeWelcomeMessage()
        // Calls the search method and wait for the search completion.
        let isSearching = searchHandler.search(text: searchBar.text) { [weak self] data, error in
            self?.hideIndicator()
            // Handle the error in the response.
            if let error = error {
                self?.show(error: error)
            } else if let data = data {
                // Handle the data received from the search.
                self?.parseRceived(response: data)
            } else {
                print("unknown response")
            }
        }
        // Show an activity indicator if the search is in progress and dismiss the keyboard.
        if isSearching {
            showIndicator()
            view.endEditing(true)
        } else {
            print("invalid search text")
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    // Decode the received JSON and create the data source to populate the TableView.
    func parseRceived(response: Data) {
        do {
            let searchResult = try JSONDecoder().decode(ARGSearchResponse.self, from: response)
            datasource.searchText = searchBar.text ?? ""
            datasource.results = searchResult.results
            tableView.reloadData()
            refreshScroll()
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
            cell.configure(withTitle: title, showAccessory: datasource.hasResults)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Show the map ViewController on selecting a valid search result.
        if datasource.hasResults,
            let mapViewController = storyboard?.instantiateViewController(withIdentifier: ARGMapViewController.storyboardIdentifier) as? ARGMapViewController {
            // Pass all the locations to the map view's data source.
            mapViewController.datasource.locationResults = datasource.results
            // Set the selected location if the user selected a particular location.
            if datasource.shouldDisplayDetails(for: indexPath) {
                mapViewController.datasource.selectedLocation = datasource.results[indexPath.row]
            }
            navigationController?.pushViewController(mapViewController, animated: true)
        }
    }
}
