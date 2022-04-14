//
//  Utils.swift
//  CryptoTracker
//
//  Created by Nirdesh Kulhar on 08/04/22.
//

import Foundation

class Utils {
    
    static func mapEntityToModel(entity :CryptoEntity)-> [Rate] {
        
        return entity.rates.map({item in
            Rate(time: item.time, asset_id_quote: item.asset_id_quote, rate: item.rate)
        })
    }
    
    static  let viewModel = CryptoViewModel(
        getCryptoUseCase: GetCryptoUseCase(repo: CryptoRepositoryImpl(datasource: CryptoAPIImpl())),
        loading: true,
        rates: [],
        searchText: "",
        error: nil,
        amount: 100
    )
}
