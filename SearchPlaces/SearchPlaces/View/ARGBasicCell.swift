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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        textLabel?.numberOfLines = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withTitle title: String, showAccessory: Bool) {
        textLabel?.text = title
        accessoryType = (showAccessory ? .disclosureIndicator : .none)
    }
}
