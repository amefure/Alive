//
//  AllLiveListView.swift
//  Alive
//
//  Created by t&a on 2023/11/25.
//

import SwiftUI

struct AllLiveListView: View {
    
    // MARK: - ViewModel
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // MARK: - View
    @State private var search: String = ""
    
    var body: some View {
        VStack {
            
            /// 検索ボックス
            CustomInputView(text: $search, imgName: "magnifyingglass", placeholder: L10n.liveArtist + "...")
                .onChange(of: search) { newValue in
                    if newValue.isEmpty {
                        repository.readAllLive()
                    } else {
                        repository.searchFilteringLive(search: search)
                    }
                }
            
            LiveScheduleListView(lives: repository.lives)
            
            AdMobBannerView()
                .frame(height: 60)
                .padding(.bottom, DeviceSizeManager.isSESize ? 70 : 100)
                
            
        }.onDisappear {
            repository.readAllLive()
        }
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .background(.foundation)
        .ignoresSafeArea()
    }
}

#Preview {
    AllLiveListView()
}
