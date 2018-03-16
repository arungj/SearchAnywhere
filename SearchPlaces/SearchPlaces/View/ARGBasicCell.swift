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
        separatorInset = .zero
        configureDisplayLabel()
    }
    
    func configureDisplayLabel() {
        contentView.addSubview(displayLabel)
        displayLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        displayLabel.textColor = .darkBlue
        displayLabel.numberOfLines = 2
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        let bottomPadding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            displayLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            displayLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            displayLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -bottomPadding),
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
