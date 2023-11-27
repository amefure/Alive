//
//  Onboarding3View.swift
//  Alive
//
//  Created by t&a on 2023/11/27.
//

import SwiftUI

struct Onboarding3View: View {
    
    var body: some View {
        VStack {
            
            Spacer()
                
            Text(L10n.onboarding3Title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .font(.system(size: 18))
                .foregroundStyle(.white)
            
            Spacer()
            
            
            if Locale.current.identifier.hasPrefix(Locale(identifier: "ja_JP").identifier) {
                Asset.Images.onboarding3Jp.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(height: DeviceSizeManager.deviceHeight / 1.5)
            } else {
//                Asset.Images.onboarding3En.swiftUIImage
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: DeviceSizeManager.deviceHeight / 1.5)
            }
            
            
            VStack {
                NavigationLink {
                    RootView()
                } label: {
                    Text(L10n.onboardingStart)
                        .padding()
                        .foregroundStyle(.white)
                        .frame(width: 200)
                        .background(.themaYellow)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                HStack {
                    Image(systemName: "circle")
                    Image(systemName: "circle")
                    Image(systemName: "circle.fill")
                }.font(.system(size: 10))
                    .foregroundStyle(.white)
                    .padding(10)
                
            }.padding(10)
                .frame(width: DeviceSizeManager.deviceWidth)
        }.navigationBarBackButtonHidden()
            .navigationBarHidden(true)
            .background(.foundation)
    }
}


#Preview {
    Onboarding3View()
}
