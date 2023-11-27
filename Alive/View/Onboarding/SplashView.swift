//
//  SplashView.swift
//  Alive
//
//  Created by t&a on 2023/11/27.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isPresented: Bool = false
    @State private var opacity: Double = 0
    
    var body: some View {
        VStack(spacing: 0) {
            
            Spacer()
            
            HStack {
                Spacer()
                
                Asset.Images.appLogoElectric.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .opacity(opacity)
                
                Spacer()
            }
            
            
            Spacer()
            
        }.navigationDestination(isPresented: $isPresented) {
            Onboarding1View()
        }.onAppear {
            withAnimation(Animation.linear(duration: 2)) {
                opacity = 1
            }
            DispatchQueue.main.asyncAfter( deadline: DispatchTime.now() + 4) {
                isPresented = true
            }
        }.background(.foundation)
            .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
