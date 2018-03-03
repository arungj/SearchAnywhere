//
//  ARGBasicCell.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import UIKit

class ARGBasicCell: UITableViewCell {
    static let reuseIdentifier = "placeCell"
    // Add a single label to the cell for displaying the text.
    let displayText = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Setting properties for the label.
        displayText.numberOfLines = 2
        displayText.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(displayText)
        
        // Autolayout constraints for the label to pin - left, top, right & bottom.
        // Left and right are pinned to the layout margin.
        NSLayoutConstraint.activate([
            displayText.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            displayText.topAnchor.constraint(equalTo: topAnchor),
            displayText.trailingAnchor.constraint(equalTo: trailingAnchor),
            displayText.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
