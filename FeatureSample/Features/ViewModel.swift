//
//  ViewModel.swift
//  FeatureSample
//
//  Created by Vitor on 11/5/2022.
//

import Foundation

enum FeatureViewModelState: Equatable {
    case loading
    case loaded([String])
    case failed(String)
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
    
    init(manager: FeatureManagerInterface) {
        self.manager = manager
    }
    
    func load() {
        viewState?(.loading)
        manager.fetchFlights { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(flights):
                self.viewState?(.loaded(flights))
            case .failure:
                self.viewState?(.failed("Failed to fetch flights"))
            }
        }
    }
    
    func addFlight() {
        navigationCallback?(.checkin)
    }
}
