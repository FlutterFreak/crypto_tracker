//
//  MockData.swift
//  CryptoTrackerTests
//
//  Created by Nirdesh Kulhar on 13/04/22.
//

import Foundation
import PromiseKit
@testable import CryptoTracker

class MockData {
    static func listLoadedSucccesFully() -> Promise<[Rate]>{
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
    
    static func listLoadingFailed() -> Promise<[Rate]>{
        return Promise.init(error: NSError(
            domain: "CryptoAPI",
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: "Failed to load data"]))
    }
    
}
