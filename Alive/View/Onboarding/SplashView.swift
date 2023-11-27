//
//  SplashView.swift
//  Alive
//
//  Created by t&a on 2023/11/27.
//

import SwiftUI

struct SplashView: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            Spacer()
            
            HStack {
                Spacer()
                
                Asset.Images.appLogoElectric.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                
                Spacer()
            }
            
            Spacer()
            
        }.navigationDestination(isPresented: $isPresented) {
            Onboarding1View()
        }.onAppear {
            DispatchQueue.main.asyncAfter( deadline: DispatchTime.now() + 2) {
                isPresented = true
            }
        }.background(.foundation)
            .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
