//
//  SettingView.swift
//  Alive
//
//  Created by t&a on 2023/11/24.
//

//
//  SettingView.swift
//  HITONOTE
//
//  Created by t&a on 2023/11/09.
//

import SwiftUI

struct SettingView: View {
    
    // MARK: - ViewModel
    private let viewModel = SettingViewModel()
    private let userDefaults = UserDefaultsRepositoryViewModel.sheard
    
    // MARK: - Environment
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            HeaderView(leadingIcon: "chevron.backward", leadingAction: { dismiss() })
            
            List {
                
                Section(header: Text(L10n.settingAppTitle)) {
                    NavigationLink {
                        Onboarding1View()
                            .environmentObject(rootEnvironment)
                    } label: {
                        HStack {
                            Image(systemName: "questionmark.app")
                                .foregroundStyle(.themaYellow)
                            Text(L10n.settingAppOnboading)
                        }
                    }
                }
                
                Section(header: Text(L10n.adsTitle), footer: Text(L10n.adsDesc1)) {
                    RewardButtonView()
                    HStack {
                        Image(systemName: "bag")
                            .foregroundStyle(.themaYellow)
                        Text(L10n.adsCurrentCapacity(userDefaults.getCapacity()))
                    }
                }
                
                Section(header: Text("Link")) {
                    // 1:レビューページ
                    Link(destination: viewModel.reviewUrl, label: {
                        HStack {
                            Image(systemName: "hand.thumbsup")
                                .foregroundStyle(.themaYellow)
                            Text(L10n.settingReviewTitle)
                        }
                    })
                    
                    // 2:シェアボタン
                    Button(action: {
                        viewModel.shareApp()
                    }) {
                        HStack {
                            Image(systemName: "star.bubble")
                                .foregroundStyle(.themaYellow)
                            Text(L10n.settingRecommendTitle)
                        }
                    }
                    
                    // 3:利用規約とプライバシーポリシー
                    Link(destination: viewModel.termsUrl, label: {
                        HStack {
                            Image(systemName: "note.text")
                                .foregroundStyle(.themaYellow)
                            Text(L10n.settingTermsOfServiceTitle)
                            Image(systemName: "link").font(.caption)
                        }
                    })
                    
                }
            }.scrollContentBackground(.hidden)
                .background(.foundation)
            
            AdMobBannerView()
                .frame(height: 60)
                .padding(.bottom, DeviceSizeManager.isSESize ? 25 : 20)
            
        }.navigationBarBackButtonHidden()
            .navigationBarHidden(true)
            .background(.foundation)
            .foregroundStyle(.white)
    }
}


#Preview {
    SettingView()
}
