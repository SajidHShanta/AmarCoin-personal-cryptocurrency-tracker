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
        Text(coin.name)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        //dev.coin come from PreviewProvider extension
        CoinRowView(coin: dev.coin)
    }
}
