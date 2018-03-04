//
//  ARGServices.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import Foundation

protocol ARGServices { }

extension ARGServices {
    func send(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionTask {
        
        // Using the default session which comes with default policies for caching, timeout etc.
        let session = URLSession.shared
        
        // Create a data task since this a GET request.
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                // If there is an error return immediately.
                completion(nil, error)
                
                // Check if the response status code is 200. Else return error.
                // Validate the response data.
            } else if let resp = response as? HTTPURLResponse,
                resp.statusCode == 200,
                let data = data {
                // Call completion for success cases.
                completion(data, nil)
            } else {
                // Call completion for failure cases. Additional error handling can be done here.
                completion(nil, nil)
            }
        }
        task.resume()
        return task
    }
}
