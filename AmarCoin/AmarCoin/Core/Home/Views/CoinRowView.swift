//
//  CoinRowView.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 24/1/23.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
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
            
            if showHoldingsColumn {
                VStack(alignment: .trailing) {
                    Text(coin.currentHoldingsValue.asCurrecyWith6Decimals())
                        .bold()
                    
                    Text((coin.currentHoldings ?? 0.0).asNumberString())
                }
            }
            
            VStack(alignment: .trailing) {
                Text(coin.currentPrice.asCurrecyWith6Decimals())
                    .bold()
                    .foregroundColor(Color.theme.accent)
                
                Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                    .foregroundColor(
                        (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red
                    )
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        //dev.coin come from PreviewProvider extension
        CoinRowView(coin: dev.coin, showHoldingsColumn: true)
    }
}
