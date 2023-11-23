//
//  LiveListView.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import SwiftUI
import PhotosUI

struct LiveScheduleListView: View {
    
    private let dateFormatManager = DateFormatManager()
    
    // MARK: - ViewModel
    private let userDefaultsRepository = UserDefaultsRepositoryViewModel.sheard
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // MARK: - View
    @State private var search:String = ""            // 検索テキスト
    @State private var isShowInput = false           // Input画面表示
    @State private var isShowSetting = false         // 設定画面表示
    
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView()
                
                HStack {
                    Button {
                        
                    } label: {
                        Text("Schedule")
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Artist")
                    }

                }
                List {
                    ForEach(repository.lives) { live in
                        NavigationLink {
                            DetailLiveView(live: live)
                        } label: {
                            HStack {
                                Text(dateFormatManager.getShortString(date: live.date))
                                Text(dateFormatManager.getDayOfWeekString(date: live.date))
                                Text(live.artist)
                                Text(live.venue)
                            }
                            
                        }
                    }
                }.listStyle(.grouped)
                .scrollContentBackground(.hidden)
                .background(.foundation)
            }
            
            
            FooterView()
            
            
        }.background(.foundation)
            .onAppear {
                repository.readAllLive()
            }.tint(.themaYellow)
        
    }
}

#Preview {
    LiveScheduleListView()
}
