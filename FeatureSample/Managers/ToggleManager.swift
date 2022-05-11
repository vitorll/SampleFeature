//
//  ToggleManager.swift
//  FeatureSample
//
//  Created by Vitor on 11/5/2022.
//

import Foundation

public enum Feature: Equatable {
    case redeemPoints, newLoginFlow, featureB
}

public protocol ToggleManagerInterface {
    func isOn(_ toggle: Feature) -> Bool
}

final class ToggleManager: ToggleManagerInterface {
    /// Inject necessary classes in order to be able to tell if a feature should be enabled or not
    
    func isOn(_ toggle: Feature) -> Bool {
        switch toggle {
        case .redeemPoints: return true
        case .newLoginFlow: return true
        case .featureB: return false
        }
    }

}
