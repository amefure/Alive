//
//  ContentView.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/11/30.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var repository = RepositoryViewModel.shared
    
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    
    @State private var selectPage: Int = 0
    
    // MARK: - View
    // 本日を含む後のライブのみを全て表示
    private var filteringNextLives: [Live] {
        repository.lives.filter { $0.date >= Calendar.current.startOfDay(for: Date()) }.reversed()
    }
    
    var body: some View {
        NavigationStack {
            
            if selectPage == 0 {
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
                
            } else {
                List {
                    ForEach(repository.lives) { live in
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
            
            
            Spacer()
            
            HStack(spacing: 10){
                
                Button {
                    selectPage = 0
                } label: {
                    Image(systemName: "person.text.rectangle")
                        .padding(5)
                        .background(Color.foundation)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }.buttonStyle(.borderless)
            
                Button {
                    selectPage = 1
                } label: {
                    Image(systemName: "list.bullet")
                        .padding(5)
                        .background(Color.foundation)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }.buttonStyle(.borderless)
            }
    
        }
    }
}

#Preview {
    ContentView()
}
