//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Nirdesh Kulhar on 31/03/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm : CryptoViewModel
    init(getCryptoUseCase: GetCrypto = .init()){
        _vm = StateObject(wrappedValue: CryptoViewModel(getCryptoUseCase: getCryptoUseCase))
    }
    var body: some View {
        NavigationView {
            VStack( ) {
                VStack {
                    Stepper("Amount: \(Int(vm.amount))€", value: $vm.amount, step: 100).accessibility(identifier: "Stepper")
                    Slider(value: $vm.amount, in: 1...10_000).accessibility(identifier: "Slider")
                }
                .padding()
                if  vm.loading == true {
                    ProgressView()
                }else {
                    List(vm.filteredRates) { item in
                        HStack {
                            Text(item.asset_id_quote)
                                .bold()
                            Spacer()
                            Text("\(vm.calcRate(rate: item), specifier: "%.2f")")
                        }
                    }
                    .listStyle(.plain)
                    .searchable(text: $vm.searchText)
                    .accessibility(identifier: "CryptoList")
                }
                Spacer()
            }
            .navigationTitle("Crypto Tracker")
            .toolbar {
                ToolbarItem {
                    Button("Refresh", action: vm.refreshData)
                }
            }.alert(item: $vm.error ){  error in
                Alert(title: Text("Error"),
                      message: Text(error.errorString),
                                      dismissButton: .cancel())
            }
          
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        .task {
            vm.refreshData()
        }
      
        
    }
}

struct ContentView_Previews: PreviewProvider {
    let getCryptoUseCase = GetCryptoUseCase(repo: CryptoRepositoryImpl(datasource: CryptoAPIImpl()))
    static var previews: some View {
        ContentView(getCryptoUseCase: getCryptoUseCase)
    }
}


