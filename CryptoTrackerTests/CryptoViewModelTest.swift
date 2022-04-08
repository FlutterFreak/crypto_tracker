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

    
    func test_crypto_view_model_loads_rate_list(){
        let  mockGetCryptoUseCase: GetCrypto = MockGetCryptoUseCase()
        self.viewModel = .init(getCryptoUseCase : mockGetCryptoUseCase )
        
        self.viewModel.refreshData()
       
        XCTAssertTrue(viewModel.rates.count>0)
    }

}
