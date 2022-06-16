//
//  FeatureDomainModel.swift
//  FeatureSample
//
//  Created by Vitor on 16/6/2022.
//

// At the Domain level we shall have the structure needed to workout our feature
// Somethings might still be optional at this point given not everything will exists
// But the main part of the feature should be covered by now or be removed
struct FeatureDomainModel {
    let id: Int
    let name: String
    let address: String?
    let points: Int
}
