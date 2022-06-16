//
//  FeatureManager.swift
//  FeatureSample
//
//  Created by Vitor on 11/5/2022.
//

import Foundation

enum FeatureManagerResult {
    case success([FeatureModel])
    case error(String)
}

protocol FeatureManagerInterface {
    func fetchFlights(_ completion: @escaping ((FeatureManagerResult) -> Void))
}

final class FeatureManager {
    private let datasource: FeatureDataSourceInterface
    
    init(datasource: FeatureDataSourceInterface) {
        self.datasource = datasource
    }
    
    static func map(_ domainModels: [FeatureDomainModel]) -> [FeatureModel] {
        []
    }
}

extension FeatureManager: FeatureManagerInterface {
    func fetchFlights(_ completion: @escaping ((FeatureManagerResult) -> Void)) {
        datasource.fetchFlights { result in
            switch result {
            case let .success(domainModels):
                let models = FeatureManager.map(domainModels)
                completion(.success(models))
            case let .failure(error):
                completion(.error(error.localizedDescription)) // Handle errors and retry logic. Parse error to be presented by the UI
            }
        }
    }
}
