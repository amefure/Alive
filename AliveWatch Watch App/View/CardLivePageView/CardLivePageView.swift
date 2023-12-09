//
//  CardLivePageView.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/12/09.
//

import SwiftUI

struct CardLivePageView: View {
    
    // MARK: - Receive
    public let lives: [Live]
    
    // MARK: - View
    // 本日を含む後のライブのみを全て表示
    private var filteringNextLives: [Live] {
        lives.filter { $0.date >= Calendar.current.startOfDay(for: Date()) }.reversed()
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if filteringNextLives.count != 0 {
                    ForEach(filteringNextLives) { live in
                        NavigationLink {
                            DetailLiveView(live: live)
                        } label: {
                            CardLiveView(live: live)
                        }.buttonStyle(.borderless)
                    }
                } else {
                    CardLiveView(live: Live.blankLive)
                }
            }
        }
    }
}

#Preview {
    CardLivePageView(lives: Live.demoLives)
}
