//
//  CryptoRepositoryImpl.swift
//  CryptoTracker
//
//  Created by Nirdesh Kulhar on 07/04/22.
//


import PromiseKit
struct CryptoRepositoryImpl: CryptoRepository{
    var datasource: CryptoDataSource
    
    func getCryptoData(currency: String ) -> Promise<[Rate]>{
        
        let _cryptos = datasource.getCryptoData(currency: "EUR")
        
        return _cryptos
    }
}
