//
//  testView.swift
//  YourFirstFeature
//
//  Created by 서원지 on 10/24/23.
//

import SwiftUI

struct GradientView: View {
    @Binding var yOffset: CGFloat
    @State var tap: Bool = false
    @State private var animateGradient = false
    
    var body: some View {
        let gradient = Gradient(stops: [
            Gradient.Stop(color: .mint, location: 0.0),
            Gradient.Stop(color: .white, location: yOffset)
        ])
        
        withAnimation(.easeIn) {
            VStack {
                if animateGradient {
                    LinearGradient(colors: [.purple, .yellow], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea(.all)
                }
                
                

                    
            }
            .onAppear {
                withAnimation(.linear(duration: 2.0)) {
                    animateGradient = true
                }
            }
        }
        
        
    }
}




#Preview {
    GradientView(yOffset: .constant(1))
}
