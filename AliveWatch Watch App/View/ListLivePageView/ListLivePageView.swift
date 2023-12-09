//
//  ListLiveView.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/12/09.
//

import SwiftUI

struct ListLivePageView: View {
    
    // MARK: - Receive
    public let lives: [Live]
    
    var body: some View {
        List {
            ForEach(lives) { live in
                NavigationLink {
                    DetailLiveView(live: live)
                } label: {
                    HStack {
                        Text(DateFormatManager().getStringBlake(date: live.date))
                            .font(.system(size: 9))
                            .frame(width: 40)
                        Text(live.artist)
                            .font(.system(size: 12))
                            .fontWeight(.bold)
                    }
                }.buttonStyle(.borderless)
            }
        }
    }
}

#Preview {
    ListLivePageView(lives: Live.demoLives)
}
