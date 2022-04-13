//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Nirdesh Kulhar on 31/03/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm : CryptoViewModel
    
    init(getCryptoUseCase: GetCrypto){
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
                    ProgressView().accessibility(identifier: "ProgressView")
                        .onAppear {
                            vm.refreshData()
                    }
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
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .alert(item: $vm.error ){  error in
            Alert(title: Text("Error"),
                  message: Text(error.errorString),
                                  dismissButton: .cancel())
        }
      
        
    }
}

struct ContentView_Previews: PreviewProvider {
   
    static var previews: some View {
        ContentView(getCryptoUseCase: CryptoTrackerApp.getCryptoUseCase)
    }
}


