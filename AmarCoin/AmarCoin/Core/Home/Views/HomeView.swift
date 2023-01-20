//
//  HomeView.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 20/1/23.
//

import SwiftUI

struct HomeView: View {
    @State private var showProtfolio: Bool = false
    
    var body: some View {
        ZStack {
            //background layer
            Color.theme.background
                .ignoresSafeArea()
            
            //content layer
            VStack {
                homeHeader
                
                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true) //cause we will use custom header
        }    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showProtfolio ? "plus" : "info")
                .animation(.none, value: showProtfolio)
                .background(
                    CircleButtonAnimationView(animate: $showProtfolio)
                )
            
            Spacer()
            
            Text(showProtfolio ? "My Protfolio" : "Live Prices")
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .animation(.none, value: showProtfolio)

            Spacer()
            
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showProtfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation {
                        showProtfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}
