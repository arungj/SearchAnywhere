//
//  ARGSearchResultsDataSource.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import Foundation

struct ARGSearchResultsDataSource {
    var searchText = ""
    let displayAllOnMap = "Display All on Map"
    let noResults = "No Results"
    var results = [ARGLocationDetails]()
    
    var numberOfSections: Int {
        if searchText.count == 0 {
            return 0
        } else if results.count < 2 {
            return 1
        } else {
            return 2
        }
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if results.count > 1 {
           return results.count
        } else {
            return 0
        }
    }
    
    func titleFor(indexPath: IndexPath) -> String {
        if indexPath.section == 0 {
            if results.count == 0 {
                return noResults
            } else if results.count > 1 {
                return displayAllOnMap
            }
        }
        let rowData = results[indexPath.row]
        return rowData.formatted_address
    }
    
    func height(forSection section: Int) -> Float {
        if section == 0 {
            return 50
        }
        return 20
    }
    
    var hasSearchResults: Bool {
        return results.count > 0
    }
    
    func isLocationAvailable(at indexPath: IndexPath) -> Bool {
        if hasSearchResults {
            if indexPath.section == 0 && results.count > 1 {
                return false
            }
            return true
        }
        return false
    }
}
