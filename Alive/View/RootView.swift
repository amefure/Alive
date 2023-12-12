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
    
    // MARK: - Environment
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    
    // MARK: - View
    @State private var selectedTab = 1
    @State private var isShowSetting = false
    @State private var isShowShare = false
    
    var body: some View {
        
        ZStack {
            VStack {
                HeaderView(leadingIcon: "square.and.arrow.up", trailingIcon: "gearshape", leadingAction: {
                    isShowShare = true
                }, trailingAction: {
                    isShowSetting = true
                }).tint(.themaYellow)
                
                TabView(selection: $selectedTab ) {
                    
                    MainView(selectedTab: $selectedTab)
                        .environmentObject(rootEnvironment)
                        .tag(1)
                    
                    
                    ArtistCountChartView()
                        .tag(2)
                    
                    // フッターには表示されていないタブ(リストAllボタンで表示)
                    // タブにしないと詳細画面へ遷移できない
                    AllLiveListView()
                        .environmentObject(rootEnvironment)
                        .tag(3)
                    
                }
            }
            
            FooterView(selectedTab: $selectedTab)
                .environmentObject(rootEnvironment)
            
        }.background(.foundation)
            .navigationDestination(isPresented: $isShowSetting) {
                SettingView()
                    .environmentObject(rootEnvironment)
            }
            .navigationDestination(isPresented: $isShowShare) {
                ShareLiveInfoView()
            }
            .navigationBarBackButtonHidden()
            .navigationBarHidden(true)
    }
}

#Preview {
    RootView()
}
