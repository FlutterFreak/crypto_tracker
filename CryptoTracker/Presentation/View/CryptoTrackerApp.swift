//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Nirdesh Kulhar on 31/03/22.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    static let getCryptoUseCase = GetCryptoUseCase(repo: CryptoRepositoryImpl(datasource: CryptoAPIImpl()))
    var body: some Scene {
        WindowGroup {
            ContentView(getCryptoUseCase: CryptoTrackerApp.getCryptoUseCase)
        }
    }
}
