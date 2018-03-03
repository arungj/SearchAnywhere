//
//  ARGAlertable.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import UIKit

protocol ARGAlertable {
    func show(error: Error)
    func showAlert(withTitle title: String, message: String?, confirmHandler: (() -> Void)?)
}

extension ARGAlertable where Self: UIViewController {
    func show(error: Error) {
        showAlert(withTitle: "Error", message: error.localizedDescription, confirmHandler: nil)
    }
    
    func showAlert(withTitle title: String, message: String?, confirmHandler: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            confirmHandler?()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
