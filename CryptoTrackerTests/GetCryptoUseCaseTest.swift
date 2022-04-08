//
//  GetCryptoUseCaseTest.swift
//  CryptoTrackerTests
//
//  Created by Nirdesh Kulhar on 07/04/22.
//

import XCTest
import PromiseKit
@testable import CryptoTracker
class GetCryptoUseCaseTest: XCTestCase {
  
    var rates:[Rate]=[]
 
    func test_getCryptoUseCase_whenSuccessfully_retrievedData(){
        let mockRepository:CryptoRepository = MockCryptoRepository()
        let useCase = GetCryptoUseCase(repo: mockRepository )
        rates =  useCase.execute().value!
        XCTAssertNotNil(rates)
        XCTAssertTrue(rates.count>0)
        XCTAssertEqual(rates[0].asset_id_quote,"USD")
    }

}
