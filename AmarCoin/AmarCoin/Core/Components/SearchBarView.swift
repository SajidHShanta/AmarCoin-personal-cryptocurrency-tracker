//
//  SearchBarView.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 30/1/23.
//

import SwiftUI

struct SearchBarView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            
            TextField("Search", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .overlay(alignment: .trailing) {
                    Image(systemName: "x.circle.fill")
                        .padding() // by adding padding, tappable area is now bigger
                        .offset(x: 10)
                        .foregroundColor(searchText.isEmpty ? Color.theme.secondaryText.opacity(0) : Color.theme.accent)
                        .onTapGesture {
                            searchText = ""
                        }
                }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15), radius: 10)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
            .previewLayout(.sizeThatFits)
    }
}
