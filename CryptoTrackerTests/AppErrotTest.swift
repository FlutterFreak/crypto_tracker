//
//  AppErrotTest.swift
//  CryptoTrackerTests
//
//  Created by Nirdesh Kulhar on 13/04/22.
//

import XCTest

class AppErrotTest: XCTestCase {

    func test_app_error(){
        let appError = AppError(errorString: "Test Error")
        XCTAssertEqual(appError.errorString, "Test Error")
        XCTAssertNotNil(appError.id)
        
    }

}
