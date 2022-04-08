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
    
    func getCryptoData(currency: String) -> Promise<[Rate]> {
        var rates:[Rate]=[]
        if let path = Bundle(for: GetCryptoUseCaseTest.self).path(forResource: "CryptoAPI", ofType: "json") {
            do {
                if   let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe){
                    let cryptoEntity = try JSONDecoder().decode(CryptoEntity.self, from: data)
                     rates = Utils.mapEntityToModel(entity:cryptoEntity)
                }
            
            }
            catch {
                // handle error
            }
        }
        return Promise.value(rates)
    }
 
}
