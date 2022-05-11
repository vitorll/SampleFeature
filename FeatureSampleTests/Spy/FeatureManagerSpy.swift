//
//  FeatureManagerSpy.swift
//  FeatureSampleTests
//
//  Created by Vitor on 11/5/2022.
//

import XCTest
import FeatureSample

final class FeatureManagerSpy: FeatureManagerInterface {
    
    private(set) var receivedCompletion = [FeatureManagerResult]()
    
    func fetchFlights(_ completion: @escaping (FeatureManagerResult)) {
        receivedCompletion.append(completion)
    }
    
    func completeSuccessfully(index: Int, flights: [String]) {
        receivedCompletion[index](.success(flights))
    }
    
    func compelteFailure(index: Int, error: Error) {
        receivedCompletion[index](.failure(error))
    }
    
}
