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
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Asset.Colors.themaGreen.swiftUIColor)
                TextField(L10n.liveArtist + "...", text: $search)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: search) { newValue in
                        if newValue.isEmpty {
                            filteringLives = lives
                        } else {
                            filteringLives = lives.filter( {$0.artist.contains(search) || $0.name.contains(search) })
                        }
                        
                    }
            }.padding(.horizontal, 20)
                .padding(.top, 10)
            
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
