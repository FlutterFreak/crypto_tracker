//
//  AppError.swift
//  CryptoTracker
//
//  Created by Nirdesh Kulhar on 13/04/22.
//

import Foundation

struct AppError: Identifiable {
    var id = UUID().uuidString
    let errorString: String
}
