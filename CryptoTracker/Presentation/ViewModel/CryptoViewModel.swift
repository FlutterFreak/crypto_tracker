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
    
    @Published private(set) var loading : Bool
    @Published private(set) var rates : [Rate]
    @Published  var searchText : String
    @Published  var error : AppError?
    @Published  var amount : Double
    
    init(getCryptoUseCase : GetCrypto ,
         loading : Bool ,
         rates : [Rate] ,
         searchText : String ,
         error : AppError? ,
         amount : Double ){
        self.getCryptoUseCase = getCryptoUseCase
        self.loading = loading
        self.rates = rates
        self.searchText = searchText
        self.error = error
        self.amount = amount
        
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
