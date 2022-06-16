//
//  FeatureService.swift
//  FeatureSample
//
//  Created by Vitor on 16/6/2022.
//

import Foundation

typealias FeatureServiceResult = ((Result<[FeatureAPIModel], Error>) -> Void)
protocol FeatureServiceInterface {
    /// Fetch data from API service
    func get(_ completion: @escaping (FeatureServiceResult))
}

final class FeatureService {
    /// Have the HTTP client injected here so we are able to test this class functionality
}

extension FeatureService: FeatureServiceInterface {
    func get(_ completion: @escaping (FeatureServiceResult)) { }
}
