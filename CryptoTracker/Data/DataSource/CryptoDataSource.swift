//
//  CryptoDataSource.swift
//  CryptoTracker
//
//  Created by Nirdesh Kulhar on 07/04/22.
//


import PromiseKit

protocol CryptoDataSource{
    
    func getCryptoData(currency: String) -> Promise<[Rate]>
    
}
