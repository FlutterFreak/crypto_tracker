//
//  RateModelTest.swift
//  CryptoTrackerTests
//
//  Created by Nirdesh Kulhar on 13/04/22.
//

import XCTest

class RateModelTest: XCTestCase {

    func test_rate_model(){
        let rate = Rate(id: "11", time: "12:00", asset_id_quote: "EUR", rate: 5.5)
        XCTAssertNotNil(rate.id)
        XCTAssertEqual(rate.id, "11")
        XCTAssertEqual(rate.time, "12:00")
        XCTAssertEqual(rate.asset_id_quote, "EUR")
        XCTAssertEqual(rate.rate, 5.5)
    }


}
