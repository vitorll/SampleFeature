//
//  ToggleManagerSpy.swift
//  FeatureSampleTests
//
//  Created by Vitor on 11/5/2022.
//

import Foundation
import FeatureSample

final class ToggleManagerSpy: ToggleManagerInterface {
    private(set) var receivedToggle: Feature!
    private var toggleFeature = false
    
    func toggle() {
        toggleFeature = true
    }
    
    func isOn(_ toggle: Feature) -> Bool {
        receivedToggle = toggle
        return toggleFeature
    }
    
}
