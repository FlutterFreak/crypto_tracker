//
//  MockCryptoRepository.swift
//  CryptoTrackerTests
//
//  Created by Nirdesh Kulhar on 08/04/22.
//

import Foundation
import PromiseKit
@testable import CryptoTracker

class MockCryptoRepository : CryptoRepository{
    let mockData:Promise<[Rate]>
    
    init(mockData: Promise<[Rate]>) {
        self.mockData = mockData
    }
    
    func getCryptoData(currency: String) -> Promise<[Rate]> {
        return mockData
    }
    
}
