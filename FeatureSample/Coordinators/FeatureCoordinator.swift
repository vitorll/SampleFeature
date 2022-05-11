//
//  Coordinator.swift
//  FeatureSample
//
//  Created by Vitor on 11/5/2022.
//

import UIKit

/// Whoever calls `makeWith` will be the coordinator of this screen.
/// It needs to hold the navigation callback from the ViewModel
/// The only class to create view controllers should be a `Coordinator`!
final class FeatureCoordinator {
    /// This class is responsible for handling the presentation and dismiss of views
    /// It'll be injected with the navigation controller currently displayed on the screen so it can present new ones
    private var navigationController: UINavigationController!
    
    func start() {
        let manager = FeatureManager()
        // Set all managers that this view model needs
        let viewModel = FeatureViewModel(manager: manager)
        viewModel.navigationCallback = { action in
            switch action {
            case .login: break // `makeWith` the login screen
            case .checkin: break // `makeWith` the checkin screen
            case .welcome: break // `makeWith` the welcome screen
            }
        }
        
        let viewController = FeatureViewController.makeWith(viewModel: viewModel)
        navigationController.present(viewController, animated: true)
    }
}
