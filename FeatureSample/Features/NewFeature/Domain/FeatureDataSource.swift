//
//  FeatureDataSource.swift
//  FeatureSample
//
//  Created by Vitor on 16/6/2022.
//

import Foundation

typealias FeatureDataSourceResult = ((Result<[FeatureDomainModel], Error>) -> Void)
protocol FeatureDataSourceInterface {
    func fetchFlights(_ completion: @escaping (FeatureDataSourceResult))
}

final class FeatureDataSource {
    private let service: FeatureServiceInterface
    
    init(service: FeatureServiceInterface) {
        self.service = service
    }
        
    static func map(_ result: [FeatureAPIModel]) -> [FeatureDomainModel] {
        []
    }
}

extension FeatureDataSource: FeatureDataSourceInterface {
    func fetchFlights(_ completion: @escaping (FeatureDataSourceResult)) {
        service.get { result in
            switch result {
            case let .success(apiModels):
                completion(.success(FeatureDataSource.map(apiModels)))
            case let .failure(error):
                completion(.failure(error)) // Map error to Domain level here. Elaborate error message
            }
        }
    }
}
