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
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            HeaderView(leadingIcon: "chevron.backward", leadingAction: { dismiss() })
                .tint(Asset.Colors.themaYellow.swiftUIColor)
            
            List {
               
                Section(header: Text("広告"), footer: Text("・追加される容量は10個です。\n・容量の追加は1日に1回までです。")) {
                    RewardButtonView()
                       HStack {
                           Image(systemName: "bag")
                           Text("現在の容量:\(userDefaults.getCapacity())個")
                       }
                   }
                
                Section(header: Text("Link")) {
                    // 1:レビューページ
                    Link(destination: viewModel.reviewUrl, label: {
                        HStack {
                            Image(systemName: "hand.thumbsup")
                            Text(L10n.settingReviewTitle)
                        }
                    })
                    
                    // 2:シェアボタン
                    Button(action: {
                        viewModel.shareApp()
                    }) {
                        HStack {
                            Image(systemName: "star.bubble")
                            Text(L10n.settingRecommendTitle)
                        }
                    }
                    
                    // 3:利用規約とプライバシーポリシー
                    Link(destination: viewModel.termsUrl, label: {
                        HStack {
                            Image(systemName: "note.text")
                            Text(L10n.settingTermsOfServiceTitle)
                            Image(systemName: "link").font(.caption)
                        }
                    })
                    
                }
            }.scrollContentBackground(.hidden)
                .background(.foundation)
            
        }.navigationBarBackButtonHidden()
            .navigationBarHidden(true)
            .background(.foundation)
            .foregroundStyle(.white)
    }
}


#Preview {
    SettingView()
}
