//
//  FeatureManager.swift
//  FeatureSample
//
//  Created by Vitor on 11/5/2022.
//

import Foundation

public protocol FeatureManagerInterface {
    typealias FeatureManagerResult = ((Result<[String], Error>) -> Void)
    func fetchFlights(_ completion: @escaping (FeatureManagerResult))
}

final class FeatureManager: FeatureManagerInterface {
    /// Have the HTTP client injected here so we are able to test this class functionality
    func fetchFlights(_ completion: @escaping (FeatureManagerResult)) {
        /// Fetch data from API service
    }
}
