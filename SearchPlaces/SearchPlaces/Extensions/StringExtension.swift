//
//  StringExtension.swift
//  SearchPlaces
//
//  Created by Arun George on 3/11/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import Foundation

extension String {
    var nonEmptyValue: String? {
        if !isEmpty { return self }
        return nil
    }
}
