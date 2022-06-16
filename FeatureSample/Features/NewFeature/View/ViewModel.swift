//
//  ViewModel.swift
//  FeatureSample
//
//  Created by Vitor on 11/5/2022.
//

import Foundation

enum FeatureViewModelState: Equatable {
    case loading
    case loaded([FeatureModel])
    case failed(String)
    case redeemPoints
}

extension FeatureViewModel {
    enum Navigation {
        case login, welcome, checkin
    }
}

/// Following SRP it is better to have small specific interfaces than a single generic one
/// Otherwise we make the implementation of said interface compulsory on non required classes
protocol FeatureViewModelNavigationInterface {
    var navigationCallback: ((FeatureViewModel.Navigation) -> Void)? { get set }
}

protocol FeatureViewModelInterface {
    var viewState: ((FeatureViewModelState) -> Void)? { get set }

    func load()
    func addFlight()
}


final class FeatureViewModel: FeatureViewModelInterface, FeatureViewModelNavigationInterface {
    /// We can update these 2 to use Combine without much hassle
    var viewState: ((FeatureViewModelState) -> Void)?
    var navigationCallback: ((Navigation) -> Void)?
    
    private var manager: FeatureManagerInterface
    private var toggleManager: ToggleManagerInterface
    
    init(manager: FeatureManagerInterface, toggleManager: ToggleManagerInterface) {
        self.manager = manager
        self.toggleManager = toggleManager
    }
    
    func load() {
        if toggleManager.isOn(.redeemPoints) {
            /// In case this feature calls a new view controller we should trigger the navigation callabck
            /// so the Coordiantor will be able to present the view controller
            viewState?(.redeemPoints)
        } else {
            fetchFlights()
        }
    }
    
    func addFlight() {
        navigationCallback?(.checkin)
    }
}

private extension FeatureViewModel {
    
    func fetchFlights() {
        viewState?(.loading)

        manager.fetchFlights { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(flights):
                self.viewState?(.loaded(flights))
            case let .error(message):
                self.viewState?(.failed(message))
            }
        }
    }

}
