//
//  CryptoModel.swift
//  CryptoTracker
//
//  Created by Nirdesh Kulhar on 31/03/22.
//

import Foundation

struct Rate: Identifiable,Equatable {
    var id = UUID().uuidString
    let time: String
    let asset_id_quote: String
    let rate: Double
}
