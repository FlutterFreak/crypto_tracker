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
    
    @Published private(set) var loading = true
    @Published private(set) var rates : [Rate] = []
    @Published  var searchText = ""
    @Published  var error : AppError? = nil
    @Published  var amount: Double = 100
    
    init(getCryptoUseCase : GetCrypto ){
        self.getCryptoUseCase = getCryptoUseCase
    }
    
   var filteredRates: [Rate] {
        return searchText == "" ? rates : rates.filter { $0.asset_id_quote.contains(searchText.uppercased()) }
    }
    
   func refreshData() {
      
       firstly {
           getCryptoUseCase.execute()
       }.done(on: DispatchQueue.main) { newRates in
           self.rates = newRates
           self.loading = false
        print("Successfully got new rates: \(String(describing: self.rates.count))")
       }.catch(on: DispatchQueue.main) { error in
           
           print("catched error",error.localizedDescription)
           self.loading = false
           self.error = AppError(errorString: error.localizedDescription)
         
       }

    }
    
  func calcRate(rate: Rate) -> Double {
        return amount * rate.rate
    }
}
