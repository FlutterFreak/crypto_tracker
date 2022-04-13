//
//  CryptoAPIImpl.swift
//  CryptoTracker
//
//  Created by Nirdesh Kulhar on 07/04/22.
//


import PromiseKit
import Foundation

struct CryptoAPIImpl: CryptoDataSource {
    
    
    internal func getCryptoData(currency: String) -> Promise<[Rate]>{
        
        // Create the URL
    
       let urlString = Constants.exchangeRateEndpoint + currency + Constants.exchangeRateQuery + Constants.apiKey
        
        guard let url = URL(string: urlString) else {
                   print("CryptoAPI: Invalid URL")
            return Promise.init(error: NSError(
                domain: "CryptoAPI",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        }
            
        // Attempt to retrieve data
        
        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
         }.compactMap {

             let ratesData = try JSONDecoder().decode(CryptoEntity.self, from: $0.data)
    
             return Utils.mapEntityToModel(entity:ratesData)
         }
    }
}
