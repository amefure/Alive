//
//  MainView.swift
//  Alive
//
//  Created by t&a on 2023/11/24.
//

import SwiftUI

struct RootView: View {
    
    // MARK: - ViewModel
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // MARK: - View
    @State private var selectedTab = 1
    @State private var isShowSetting = false
    
    var body: some View {
        
        ZStack {
            VStack {
                HeaderView(trailingIcon: "gearshape",trailingAction: {
                    isShowSetting = true
                }).tint(.themaYellow)
                
                TabView(selection: $selectedTab ) {
                    
                    MainView(selectedTab: $selectedTab)
                        .tag(1)
                    
                    
                    ArtistCountChartView()
                        .tag(2)
                    
                    // フッターには表示されていないタブ(リストAllボタンで表示)
                    // タブにしないと詳細画面へ遷移できない
                    AllLiveListView(lives: repository.lives)
                        .tag(3)
                    
                }
            }
            
            FooterView(selectedTab: $selectedTab)
            
        }.background(.foundation)
            .navigationDestination(isPresented: $isShowSetting) {
                SettingView()
            }
            .navigationBarBackButtonHidden()
            .navigationBarHidden(true)
    }
}

#Preview {
    RootView()
}
