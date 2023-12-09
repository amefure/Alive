//
//  ContentView.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/11/30.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - ViewModel
    @ObservedObject var repository = RepositoryViewModel.shared
    
    // MARK: - Environment
//    @EnvironmentObject private var rootEnvironment: RootEnvironment
    
    // MARK: - View
    @State private var selectPage: Int = 0
    
    var body: some View {
        NavigationStack {
            
            if selectPage == 0 {
                CardLivePageView(lives: repository.lives)
//                CardLivePageView(lives: Live.demoLives)
            } else {
                ListLivePageView(lives: repository.lives)
//                ListLivePageView(lives: Live.demoLives)
            }
            
            Spacer()
            
            // MARK: - ページ選択タブビュー
            FooterView(selectPage: $selectPage)
        }
    }
}

#Preview {
    MainView()
}
