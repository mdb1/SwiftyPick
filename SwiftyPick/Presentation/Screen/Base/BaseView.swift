//
//  BaseView.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 08/09/2021.
//

import UIKit

/// BaseView to use as parent for the main view inside a view controller.
class BaseView: UIView {
    /// The container view for the loading state
    private(set) var loadingContainerView = UIView()
    /// The loading indicator
    private(set) var activityIndicator: UIActivityIndicatorView! = UIActivityIndicatorView()

    /// Property to tell the view to start or stop loading
    var isLoading: Bool {
        get { !activityIndicator.isHidden }
        set {
            newValue ? startLoading() : stopLoading()
        }
    }

    /// Method to display a fullscreen loading in the view, override for specific loading states.
    func startLoading() {
        loadingContainerView.isHidden = false
        activityIndicator.isHidden = false
        loadingContainerView.backgroundColor = .systemBackground
        addSubview(loadingContainerView, insets: .none)
        loadingContainerView.addSubview(activityIndicator)
        activityIndicator.pinToCenter()
        activityIndicator.startAnimating()
    }

    /// Method to hide the fullscreen loading in the view, override for specific loading states.
    func stopLoading() {
        loadingContainerView.isHidden = true
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}
