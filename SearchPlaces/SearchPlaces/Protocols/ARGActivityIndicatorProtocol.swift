//
//  ARGActivityIndicatorProtocol.swift
//  SearchPlaces
//
//  Created by Arun George on 3/3/18.
//  Copyright © 2018 ARG. All rights reserved.
//

import UIKit

protocol ARGActivityIndicatorProtocol: class {
    var indicatorView: UIView? { get set }
}

extension ARGActivityIndicatorProtocol where Self: UIViewController {
    func showIndicator() {
        if indicatorView == nil {
            let canvasView = makeCanvasView()
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            spinner.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(canvasView)
            canvasView.addSubview(spinner)
            
            NSLayoutConstraint.activate([
                canvasView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                canvasView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                canvasView.widthAnchor.constraint(equalToConstant: 50),
                canvasView.heightAnchor.constraint(equalToConstant: 50),
                spinner.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: canvasView.centerYAnchor)
                ])
            indicatorView = canvasView
        }
        showWithFade()
    }
    
    func hideIndicator() {
        hideWithFade()
    }
    
    private func makeCanvasView() -> UIView {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func showWithFade() {
        if let indicator = indicatorView {
            indicator.alpha = 0
            if let spinner = indicator.subviews.first as? UIActivityIndicatorView {
                spinner.startAnimating()
            }
            UIView.animate(withDuration: 0.3, animations: {
                indicator.alpha = 1.0
            })
        }
    }
    
    private func hideWithFade() {
        if let indicator = indicatorView {
            if let spinner = indicator.subviews.first as? UIActivityIndicatorView {
                spinner.stopAnimating()
            }
            UIView.animate(withDuration: 0.3, animations: {
                indicator.alpha = 0
            })
        }
    }
}
