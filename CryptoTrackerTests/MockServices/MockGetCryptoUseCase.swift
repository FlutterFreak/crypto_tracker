//
//  MockGetCryptoUseCase.swift
//  CryptoTrackerTests
//
//  Created by Nirdesh Kulhar on 08/04/22.
//

import Foundation
import PromiseKit
import XCTest
@testable import CryptoTracker

class MockGetCryptoUseCase : GetCrypto{
    var mockData:Promise<[Rate]>
    
    init(mockData: Promise<[Rate]>) {
        self.mockData = mockData
    }
    
    func execute() -> Promise<[Rate]> {
        return mockData
        
    }
}



