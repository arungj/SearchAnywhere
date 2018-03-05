//
//  ARGBasicCell.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import UIKit

class ARGBasicCell: UITableViewCell {
    static let reuseIdentifier = "basicCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Set bold font and number of lines to 2.
        textLabel?.font = .preferredFont(forTextStyle: .headline)
        textLabel?.numberOfLines = 2
    }
    
    func configure(withTitle title: String, showAccessory: Bool) {
        textLabel?.text = title
        accessoryType = (showAccessory ? .disclosureIndicator : .none)
    }
}
