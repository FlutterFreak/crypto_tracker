//
//  CryptoViewModelTest.swift
//  CryptoTrackerTests
//
//  Created by Nirdesh Kulhar on 08/04/22.
//

import XCTest
import Quick
import Nimble
import PromiseKit
@testable import CryptoTracker
class CryptoViewModelTest: XCTestCase {
    var viewModel: CryptoViewModel!


    
    func test_crypto_view_model_error_loading_rate_list() {
        let mockdata = MockData.listLoadingFailed()
        let  mockGetCryptoUseCase = MockGetCryptoUseCase(mockData: mockdata)
        self.viewModel = .init(getCryptoUseCase : mockGetCryptoUseCase )
     
        waitUntil{ done in
            self.viewModel.refreshData()
          done()
        }
        expect(self.viewModel.error?.errorString.count).toEventually(beGreaterThan(0))
        expect(self.viewModel.error?.errorString).toEventually(equal("Failed to load data"))
   
    }
    
    func test_crypto_view_model_loads_rate_list() {
        

        let mockdata = MockData.listLoadedSucccesFully()
        let  mockGetCryptoUseCase = MockGetCryptoUseCase(mockData: mockdata)
        self.viewModel = .init(getCryptoUseCase : mockGetCryptoUseCase )

        waitUntil{ done in
            self.viewModel.refreshData()
          done()
        }
        expect(self.viewModel.rates.count).toEventually(beGreaterThan(0))
        expect(self.viewModel.rates.count).toEventually(equal(4))
    }
    
    func test_crypto_view_model_calculate_Rate() {
        let mockdata = MockData.listLoadedSucccesFully()
        let  mockGetCryptoUseCase = MockGetCryptoUseCase(mockData: mockdata)
        self.viewModel = .init(getCryptoUseCase : mockGetCryptoUseCase )
        
        XCTAssertTrue(viewModel.amount == 100)
        XCTAssertEqual(viewModel.calcRate(rate: Rate(id: "12", time: "12:00", asset_id_quote: "USD", rate:2.0)),200)
    }
    
    func test_crypto_view_model_filtered_Rates() {
        let mockdata = MockData.listLoadedSucccesFully()
        let  mockGetCryptoUseCase = MockGetCryptoUseCase(mockData: mockdata)
        self.viewModel = .init(getCryptoUseCase : mockGetCryptoUseCase )
        
        waitUntil{ done in
            self.viewModel.refreshData()
          done()
        }
        self.viewModel.searchText = "USD"
        XCTAssertTrue(viewModel.searchText == "USD")
        // Check if the there is only one value after passing search text
        expect(self.viewModel.filteredRates.count).toEventually(equal(1))
    }
}
