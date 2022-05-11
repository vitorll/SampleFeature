//
//  FeatureSampleTests.swift
//  FeatureSampleTests
//
//  Created by Vitor on 11/5/2022.
//

import XCTest
@testable import FeatureSample

final class FeatureViewModelTests: XCTestCase {

    func test_load_updateStateToLoading() {
        let (sut, manager, _) = makeSUT()
        var receivedState: FeatureViewModelState!
        sut.viewState = { receivedState = $0 }
        sut.load()
        
        XCTAssertEqual(manager.receivedCompletion.count, 1)
        XCTAssertEqual(receivedState, .loading)
    }
    
    func test_load_updateStateToLoadedWhenFlightsAvailable() {
        let (sut, manager, _) = makeSUT()
        var receivedState: FeatureViewModelState!
        sut.viewState = { receivedState = $0 }
        sut.load()

        manager.completeSuccessfully(index: 0, flights: ["Flight ABC 123"])
                
        XCTAssertEqual(receivedState, .loaded(["Flight ABC 123"]))
    }

    func test_load_updateStateToFailedWhenAnErrorIsReceived() {
        let (sut, manager, _) = makeSUT()
        var receivedState: FeatureViewModelState!
        sut.viewState = { receivedState = $0 }
        sut.load()

        manager.compelteFailure(index: 0, error: anyNSError())
        
        XCTAssertEqual(receivedState, .failed("Failed to fetch flights"))
    }
    
    func test_addFlight_triggersNavigationCallback() {
        let (sut, _, _) = makeSUT()
        var receivedCallback: FeatureViewModel.Navigation!
        sut.navigationCallback = { receivedCallback = $0 }
        sut.addFlight()
        
        XCTAssertEqual(receivedCallback, .checkin)
    }
    
    func test_load_checkFeatureToggleReturnsCorrectFeature() {
        let (sut, _, toggleManager) = makeSUT()
        
        sut.load()
        
        XCTAssertTrue(toggleManager.receivedToggle == .redeemPoints)
    }

    func test_load_updateStateAccordingToToggle() {
        let (sut, _, toggleManager) = makeSUT()
        toggleManager.toggle()
        var receivedState: FeatureViewModelState!
        sut.viewState = { receivedState = $0 }

        sut.load()
        
        XCTAssertEqual(receivedState, .redeemPoints)
    }

    // MARK: Helpers
    private func makeSUT() -> (FeatureViewModel, FeatureManagerSpy, ToggleManagerSpy) {
        let manager = FeatureManagerSpy()
        let toggleManager = ToggleManagerSpy()
        let sut = FeatureViewModel(manager: manager, toggleManager: toggleManager)
        trackForMemoryLeaks(manager, file: #file, line: #line)
        trackForMemoryLeaks(sut, file: #file, line: #line)
        return (sut, manager, toggleManager)
    }

}
