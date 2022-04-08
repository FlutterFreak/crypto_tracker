//
//  GetCryptoUseCase.swift
//  CryptoTracker
//
//  Created by Nirdesh Kulhar on 07/04/22.
//


import PromiseKit

protocol GetCrypto{
    func execute()->Promise<[Rate]>
}

struct GetCryptoUseCase: GetCrypto {
    var repo: CryptoRepository
    
    func execute()->Promise<[Rate]>{
        let cryptos = repo.getCryptoData(currency: "EUR")
        return cryptos
    }
}
