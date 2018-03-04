//
//  ARGSearchResultsDatasource.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import Foundation

struct ARGSearchResultsDatasource {
    var searchText = ""
    let displayAllOnMap = "Display All on Map"
    let noResults = "No Results"
    var results = [ARGResult]()
    
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
        } else {
            return results.count
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
    
    var shouldDisplayAccessory: Bool {
        return results.count > 0
    }
}
