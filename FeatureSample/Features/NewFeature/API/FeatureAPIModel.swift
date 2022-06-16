//
//  FeatureAPIModel.swift
//  FeatureSample
//
//  Created by Vitor on 16/6/2022.
//

// An APIModel should receive all results from the backend before parsing
// If we make demands at this point we may lose results or an entire requet/response
struct FeatureAPIModel {
    let id: Int?
    let name: String?
    let address: String?
    let points: Int?
}
