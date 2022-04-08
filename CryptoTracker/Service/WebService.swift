//
//  WebService.swift
//  CryptoTracker
//
//  Created by Nirdesh Kulhar on 31/03/22.
//

import Foundation
import PromiseKit

enum ServiceError: Error{
    case badUrl, requestError, decodingError, statusNotOK
}
class WebService {
    
    func getCryptoData(currency: String, previewMode: Bool) -> Promise<[Rate]>{
        
        
                if previewMode {

                    return Promise.value(Rate.sampleRates)
                }
                
                
                
            // Create the URL
        
               let urlString = Constants.exchangeRateEndpoint + currency + "?invert=false&apikey=" + Constants.apiKey
               let url = URL(string: urlString)!
                
            // Attempt to retrieve data
       
            return firstly {
               URLSession.shared.dataTask(.promise, with: url)
             }.compactMap {

                 let ratesData = try JSONDecoder().decode(CryptoEntity.self, from: $0.data)
                 return ratesData.rates.map({item in
                     Rate(time: item.time, asset_id_quote: item.asset_id_quote, rate: item.rate)
                 })
             }
            }
}
   
    
