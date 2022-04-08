//
//  CryptoRepository.swift
//  CryptoTracker
//
//  Created by Nirdesh Kulhar on 07/04/22.
//

import PromiseKit

protocol CryptoRepository{
  
    func getCryptoData(currency: String) -> Promise<[Rate]>
    
}
