//
//  CryptoEntity.swift
//  CryptoTracker
//
//  Created by Nirdesh Kulhar on 07/04/22.
//

struct CryptoEntity: Decodable {
    let asset_id_base: String
    let rates: [RateEntity]
}

struct RateEntity: Decodable{
    let time: String
    let asset_id_quote: String
    let rate: Double
}
