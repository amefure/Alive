//
//  Onboarding2View.swift
//  Alive
//
//  Created by t&a on 2023/11/27.
//


import SwiftUI

struct Onboarding2View: View {
    
    // MARK: - Environment
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text(L10n.onboarding2Title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .font(.system(size: 18))
                .foregroundStyle(.white)
            
            Spacer()
            
            if Locale.current.identifier.hasPrefix(Locale(identifier: "ja_JP").identifier) {
                Asset.Images.onboarding2Jp.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(height: DeviceSizeManager.deviceHeight / 1.5)
            } else {
                Asset.Images.onboarding2En.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(height: DeviceSizeManager.deviceHeight / 1.5)
            }
            
            
            
            VStack {
                NavigationLink {
                    Onboarding3View()
                        .environmentObject(rootEnvironment)
                } label: {
                    Text(L10n.onboardingNext)
                        .padding()
                        .foregroundStyle(.white)
                        .frame(width: 200)
                        .background(.themaYellow)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                HStack {
                    Image(systemName: "circle")
                    Image(systemName: "circle.fill")
                    Image(systemName: "circle")
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
    Onboarding2View()
}
