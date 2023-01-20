//
//  CircleButtonAnimationView.swift
//  AmarCoin
//
//  Created by Sajid Shanta on 20/1/23.
//

import SwiftUI

struct CircleButtonAnimationView: View {
//    @State private var animate: Bool = true
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.05 : 0.9)
            .opacity(0.1)
            .animation(.easeOut(duration: 0.4), value: animate)
//            .onAppear() {
//                animate.toggle()
//            }
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(animate: .constant(true))
    }
}
