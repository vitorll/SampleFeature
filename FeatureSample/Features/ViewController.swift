//
//  ViewController.swift
//  FeatureSample
//
//  Created by Vitor on 11/5/2022.
//

import UIKit

// In case the ViewController is in Storyboard
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
            case let .loaded(flights):
                self?.updateFlightList(flights)
            case let .failed(error):
                self?.render(error)
            case .loading:
                break // Show spinner animation, etc
            }
        }
    }

}

// MARK: - View Actions
private extension FeatureViewController {
    func didTapAddFlightButton() {
        viewModel.addFlight()
    }
}

// MARK: - View State Updates
private extension FeatureViewController {
    func updateFlightList(_ flights: [String]) {
        // Update tableView with flight list
    }
    
    func render(_ error: Error) {
        // Present error message
    }
    
    func showAddFlightDetail() {
        // Present success message
    }
}
