//
//  ViewModel.swift
//  FeatureSample
//
//  Created by Vitor on 11/5/2022.
//

import Foundation

enum ViewModelFetchError: Error, Equatable {
    case failedToLoad, timeout
}

enum FeatureViewModelState: Equatable {
    case loading
    case loaded([String])
    case failed(ViewModelFetchError)
}

extension FeatureViewModel {
    enum Navigation {
        case login, welcome, checkin
    }
}

protocol FeatureViewModelNavigationProtocol {
    var navigationCallback: ((FeatureViewModel.Navigation) -> Void)? { get set }
}

protocol FeatureViewModelProtocol {
    var viewState: ((FeatureViewModelState) -> Void)? { get set }

    func load()
    func addFlight()
}


final class FeatureViewModel: FeatureViewModelProtocol, FeatureViewModelNavigationProtocol {
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
                self.viewState?(.failed(.failedToLoad))
            }
        }
    }
    
    func addFlight() {
        navigationCallback?(.checkin)
    }
}
