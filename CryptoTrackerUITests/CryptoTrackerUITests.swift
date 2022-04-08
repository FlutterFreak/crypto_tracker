//
//  CryptoTrackerUITests.swift
//  CryptoTrackerUITests
//
//  Created by Nirdesh Kulhar on 06/04/22.
//

import XCTest

class CryptoTrackerUITests: XCTestCase {
    var  app = XCUIApplication()
    override func setUp(){
        app = XCUIApplication()
        app.launch()
    }

    func test_should_display_scontrols(){
        
        XCTAssertTrue(app.steppers["Stepper"].exists)
        XCTAssertTrue(app.sliders["Slider"].exists)
    }
    
    func test_should_display_cryptoList(){
        
        let appNavBarTitle = app.staticTexts["Crypto Tracker"]
        XCTAssert(appNavBarTitle.waitForExistence(timeout: 5))
        let cryptoCount = app.tables.count
        XCTAssertTrue(cryptoCount>0)
    }
}
