//
//  CryptoAPIImpl.swift
//  CryptoTracker
//
//  Created by Nirdesh Kulhar on 07/04/22.
//


import PromiseKit

struct CryptoAPIImpl: CryptoDataSource {

    func getCryptoData(currency: String) -> Promise<[Rate]>{
        
        // Create the URL
    
        let urlString = Constants.exchangeRateEndpoint + currency + Constants.exchangeRateQuery + Constants.apiKey
           let url = URL(string: urlString)!
            
        // Attempt to retrieve data
        
        return firstly {
           URLSession.shared.dataTask(.promise, with: url)
         }.compactMap {

             let ratesData = try JSONDecoder().decode(CryptoEntity.self, from: $0.data)
    
             return Utils.mapEntityToModel(entity:ratesData)
         }
    }
}
