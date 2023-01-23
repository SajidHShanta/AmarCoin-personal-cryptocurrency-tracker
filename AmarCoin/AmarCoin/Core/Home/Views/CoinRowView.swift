//
//  CoinRowView.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 24/1/23.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    
    var body: some View {
        HStack(spacing: 0.0) {
            Text("\(coin.rank)")
                .frame(minWidth: 30)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
            
            Circle()
                .frame(width: 30, height: 30)
            
            Text("\(coin.symbol.uppercased())")
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .padding(.leading, 5.0)

            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(coin.currentPrice.asCurrecyWith6Decimals())
                    .bold()
                    .foregroundColor(Color.theme.accent)
                
                Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                    .foregroundColor(
                        (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red
                    )
            }
        }
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        //dev.coin come from PreviewProvider extension
        CoinRowView(coin: dev.coin)
    }
}
