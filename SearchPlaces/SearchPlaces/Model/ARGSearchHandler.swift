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
    
    /**
     This method takes a text to search and returns the results from the search API.
     - parameter text: The search text. If the search text is invalid, it return false.
     - parameter completion: The completion block with the response data or the error from the web service.
     - returns: True if the search text is valid, false otherwise.
     */
    func search(text: String?, completion: @escaping (Data?, Error?) -> Void) -> Bool {
        guard let searchText = text?.nonEmptyValue else { return false }
        
        // Cancel the search task if a new search is fired while a search is in progress.
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
