//
//  CryptoViewModelTest.swift
//  CryptoTrackerTests
//
//  Created by Nirdesh Kulhar on 08/04/22.
//

import XCTest
import Nimble
import PromiseKit
@testable import CryptoTracker
class CryptoViewModelTest: XCTestCase {
    let mockdata = MockData.listLoadingFailed()

    var viewModelwithData = CryptoViewModel(getCryptoUseCase: MockGetCryptoUseCase(mockData: MockData.listLoadedSucccesFully()), loading: true, rates: [], searchText: "", error: nil, amount: 100)
    
    var viewModelwithError = CryptoViewModel(getCryptoUseCase: MockGetCryptoUseCase(mockData: MockData.listLoadingFailed()), loading: true, rates: [], searchText: "", error: nil, amount: 100)
    
    
    func test_crypto_view_model_error_loading_rate_list() {
    
        
        waitUntil{ done in
            self.viewModelwithError.refreshData()
            done()
        }
        expect(self.viewModelwithError.error?.errorString.count).toEventually(beGreaterThan(0))
        expect(self.viewModelwithError.error?.errorString).toEventually(equal("Failed to load data"))
        
    }
    
    func test_crypto_view_model_loads_rate_list() {
        
        waitUntil{ done in
            self.viewModelwithData.refreshData()
            done()
        }
        expect(self.viewModelwithData.rates.count).toEventually(beGreaterThan(0))
        expect(self.viewModelwithData.rates.count).toEventually(equal(4))
    }
    
    func test_crypto_view_model_calculate_Rate() {
        
        XCTAssertTrue(viewModelwithData.amount == 100)
        XCTAssertEqual(viewModelwithData.calcRate(rate: Rate(id: "12", time: "12:00", asset_id_quote: "USD", rate:2.0)),200)
    }

}
