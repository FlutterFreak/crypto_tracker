//
//  CryptoViewModel.swift
//  CryptoTracker
//
//  Created by Nirdesh Kulhar on 31/03/22.
//


import SwiftUI
import PromiseKit
class CryptoViewModel: ObservableObject {
    
    var getCryptoUseCase :GetCrypto
    
    @Published var loading = true
    @Published var rates : [Rate] = []
    @Published var searchText = ""
    @Published var amount: Double = 100
    
    init(getCryptoUseCase : GetCrypto = GetCryptoUseCase(repo: CryptoRepositoryImpl(datasource: CryptoAPIImpl()))){
        self.getCryptoUseCase = getCryptoUseCase
    }
    
    var filteredRates: [Rate] {
        return searchText == "" ? rates : rates.filter { $0.asset_id_quote.contains(searchText.uppercased()) }
    }
    
    func refreshData() {
      
        getCryptoUseCase.execute().done(on:DispatchQueue.main) { newRates in
            print("Successfully got new rates: \(self.rates.count )")
          
                withAnimation {
                    self.rates = newRates
                    self.loading = false
                }
    
            print("Successfully got new rates: \(self.rates.count )")
         
        }.catch{[weak self] error in
            print("catched error",error)
            guard self != nil else { return }
        }
    }
    
    func calcRate(rate: Rate) -> Double {
        return amount * rate.rate
    }
}
