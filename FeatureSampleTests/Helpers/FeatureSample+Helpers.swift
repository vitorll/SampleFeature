//
//  FeatureSample+Helpers.swift
//  FeatureSampleTests
//
//  Created by Vitor on 11/5/2022.
//

import XCTest
import FeatureSample

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}
