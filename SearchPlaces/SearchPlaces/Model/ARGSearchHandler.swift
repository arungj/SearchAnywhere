//
//  ARGSearchHandler.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import Foundation

class ARGSearchHandler: NSObject, ARGServices {
    lazy var environment = ARGEnvironment()
    weak var dataTask: URLSessionTask?
    
    func search(text: String?, completion: @escaping (Data?, Error?) -> Void) -> Bool {
        guard let searchText = text,
            searchText.count > 0 else { return false }
        
        // Cancel the search task if a new search is fired while the search is in progress.
        dataTask?.cancel()
        let urlRequest = URLRequest(url: environment.serviceURL(forSearchText: searchText))
        dataTask = send(request: urlRequest) { data, error in
            DispatchQueue.main.async {
                if let err = error as NSError?,
                    err.localizedDescription == "cancelled" {
                    print("another search is fired")
                } else if let error = error {
                    completion(nil, error)
                } else {
                    completion(data, nil)
                }
            }
        }
        return true
    }
    
    deinit {
        dataTask?.cancel()
    }
}
