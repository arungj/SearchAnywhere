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
    
    // The number of sections to be shown for the current array of search results.
    var numberOfSections: Int {
        if searchText.isEmpty {
            return 0
        } else if results.count < 2 {
            return 1
        } else {
            return 2
        }
    }
    
    var shouldScroll: Bool {
        return !results.isEmpty
    }
    
    // The number of rows to be shown for the current section.
    func numberOfRows(inSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if results.count > 1 {
            return results.count
        } else {
            return 0
        }
    }
    
    // Title to be shown for the current row in the TableView.
    func titleFor(indexPath: IndexPath) -> String {
        if indexPath.section == 0 {
            if results.isEmpty {
                return noResults
            } else if results.count > 1 {
                return displayAllOnMap
            }
        }
        let rowData = results[indexPath.row]
        return rowData.formatted_address
    }
    
    // The height of the TableView section.
    func height(forSection section: Int) -> Float {
        return 20
    }
    
    // Convenience computed property to check if there are any search results.
    var hasResults: Bool {
        return !results.isEmpty
    }
    
    // Method to check if there is a valid location result is available for this row.
    func shouldDisplayDetails(for indexPath: IndexPath) -> Bool {
        if hasResults {
            if indexPath.section == 0 && results.count > 1 {
                return false
            }
            return true
        }
        return false
    }
}
