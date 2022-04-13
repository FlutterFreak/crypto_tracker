//
//  CryptoViewModelTest.swift
//  CryptoTrackerTests
//
//  Created by Nirdesh Kulhar on 08/04/22.
//

import XCTest
@testable import CryptoTracker

class CryptoViewModelTest: XCTestCase {
    var viewModel: CryptoViewModel!


    
    func test_crypto_view_model_error_loading_rate_list() {
        let mockdata = MockData.listLoadingFailed()
        let expectation = self.expectation(description: "Data loaded into list")
        expectation.expectedFulfillmentCount = 1
        let  mockGetCryptoUseCase = MockGetCryptoUseCase(mockData: mockdata)
        self.viewModel = .init(getCryptoUseCase : mockGetCryptoUseCase )
        XCTAssertTrue(viewModel.rates.isEmpty)
        self.viewModel.refreshData()
        expectation.fulfill()
        wait(for:[expectation], timeout: 20)
        XCTAssertTrue(viewModel.rates.count==0)
        XCTAssertNil(viewModel.error)
    }
    
    func test_crypto_view_model_loads_rate_list() {
        let expectation = self.expectation(description: "Data loaded into list")
        expectation.expectedFulfillmentCount = 1
        let mockdata = MockData.listLoadedSucccesFully()
        let  mockGetCryptoUseCase = MockGetCryptoUseCase(mockData: mockdata)
        self.viewModel = .init(getCryptoUseCase : mockGetCryptoUseCase )
        XCTAssertTrue(viewModel.rates.isEmpty)
        self.viewModel.refreshData()
        expectation.fulfill()
        wait(for:[expectation], timeout: 20)
        XCTAssertTrue(viewModel.rates.isEmpty)
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
        self.viewModel.searchText = "BTC"
        var rate:[Rate] = []
        rate =  self.viewModel.filteredRates
        XCTAssertTrue(viewModel.searchText == "BTC")
        XCTAssertEqual(rate.count,0)
    }
}
