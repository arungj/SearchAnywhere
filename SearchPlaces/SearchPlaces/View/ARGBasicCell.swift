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
    let displayLabel = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureDisplayLabel()
    }
    
    func configureDisplayLabel() {
        contentView.addSubview(displayLabel)
        displayLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        displayLabel.textColor = .darkBlue
        displayLabel.numberOfLines = 2
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            displayLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            displayLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: padding),
            displayLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -padding),
            displayLabel.rightAnchor.constraint(equalTo: contentView.layoutMarginsGuide.rightAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(withTitle title: String, showAccessory: Bool) {
        displayLabel.text = title
        accessoryType = (showAccessory ? .disclosureIndicator : .none)
    }
}
