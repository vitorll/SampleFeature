//
//  ViewController.swift
//  FeatureSample
//
//  Created by Vitor on 11/5/2022.
//

import UIKit

/// In case the ViewController is in Storyboard it should be created through this function
/// It'll setup all necessary depednencies in order to make this view controller work
/// Should *only* be called by a `Coordinator`
extension FeatureViewController {
    static func makeWith(viewModel: FeatureViewModelInterface) -> FeatureViewController {
        let bundle = Bundle(for: FeatureViewController.self)
        let storyboard = UIStoryboard(name: "Feature", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! FeatureViewController
        feedController.viewModel = viewModel
        return feedController
    }
}

final class FeatureViewController: UIViewController {

    private var viewModel: FeatureViewModelInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
    }

    func set(_ model: FeatureViewModelInterface) {
        viewModel = model
        viewModel.viewState = { [weak self] state in
            // Stop loading animation

            switch state {
            case .loading:
                break // Show spinner animation, etc
            case let .loaded(flights):
                self?.updateFlightList(flights)
            case let .failed(error):
                self?.render(error)
            case .redeemPoints:
                self?.showRedeemPoints()
            }
        }
    }

}

// MARK: - View Actions

/// A view controller shouldn't process anything itself, on receiving input the same should be sent to the viewmodel for processing
private extension FeatureViewController {
    func didTapAddFlightButton() {
        viewModel.addFlight()
    }
}

// MARK: - View State Updates

/// This is what a view controller should be about, it reacts to changes on the view model to update its components
/// Ideally no logic should be here! Only simple comands telling labels, buttons, etc how they should look like
private extension FeatureViewController {
    func updateFlightList(_ flights: [FeatureModel]) {
        // Update tableView with flight list
    }
    
    func render(_ error: String) {
        // Present error message
    }
    
    func showAddFlightDetail() {
        // Present success message
    }
    
    func showRedeemPoints() {
        /// New feature can be safely called here in case it is a component/widget of this view controller
    }
}
