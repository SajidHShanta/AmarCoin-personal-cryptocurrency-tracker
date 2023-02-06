//
//  ProtfolioView.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 3/2/23.
//

import SwiftUI

struct EditProtfolioView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                SearchBarView(searchText: $vm.searchText)
                
                coinLogoList
                
                if selectedCoin != nil {
                    protfolioInputForm
                }
            }
            .navigationTitle("Edit Protfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Image(systemName: "xmark")
                        .onTapGesture {
                            dismiss()
                        }
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    saveButton
                })
            }
            .onChange(of: vm.searchText) { text in
                //remove selected data on dismiss button (in search bar)
                if text == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

struct ProtfolioView_Previews: PreviewProvider {
    static var previews: some View {
        EditProtfolioView()
            .environmentObject(dev.homeVM)
    }
}

extension EditProtfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(5)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.accent : Color.clear, lineWidth: 1)
                        }
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
    }
    
    private var protfolioInputForm: some View {
        VStack {
            HStack {
                Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? ""):")

                Spacer()

                Text(selectedCoin?.currentPrice.asCurrecyWith6Decimals() ?? "")
            }
            
            Divider()
            
            HStack {
                Text("Ammount holding:")
                
                Spacer()
                
                TextField("Ex. 1.5", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            
            Divider()
            
            HStack {
                Text("Current value:")
                
                Spacer()
                
                Text(getCurrentValue().asCurrecyWith6Decimals())
            }
        }
        .transaction { transaction in
            transaction.animation = nil
        }
        .padding()
        .font(.headline)
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var saveButton: some View {
        HStack {
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1 : 0)
            
            Button("Save") {
                saveButtonPressed()
            }
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ?
                1 : 0
            )
        }
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin else { return }
        
        // save to protfolio
        // to-do
        
        // show checkmark
        withAnimation {
            showCheckMark = true
            removeSelectedCoin()
        }
        
        // hide/ dismiss keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark after 1 sec
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeOut) {
                showCheckMark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}
