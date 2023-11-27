//
//  AllLiveListView.swift
//  Alive
//
//  Created by t&a on 2023/11/25.
//

import SwiftUI

struct AllLiveListView: View {
    
    // MARK: - Receive
    public let lives: [Live]
    
    // MARK: - View
    @State private var filteringLives: [Live] = []
    @State private var search: String = ""
    
    var body: some View {
        VStack {
            
            /// 検索ボックス
            CustomInputView(text: $search, imgName: "magnifyingglass", placeholder: L10n.liveArtist + "...")
                .onChange(of: search) { newValue in
                    if newValue.isEmpty {
                        filteringLives = lives
                    } else {
                        filteringLives = lives.filter( {$0.artist.contains(search) || $0.name.contains(search) })
                    }
                }
            
            LiveScheduleListView(lives: filteringLives)
            
            AdMobBannerView()
                .frame(height: 60)
            
        }.onAppear {
            filteringLives = lives
        }
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .background(.foundation)
    }
}

#Preview {
    AllLiveListView(lives: [])
}
