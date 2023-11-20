//
//  ArtistGridListView.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import SwiftUI

struct ArtistGridListView: View {
    
    // MARK: - Utility
    private let imageFileManager = ImageFileManager()
    
    // MARK: - ViewModel
    private let userDefaultsRepository = UserDefaultsRepositoryViewModel.sheard
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // MARK: - View
    @State private var search:String = ""            // 検索テキスト
    @State private var isShowInput = false           // Input画面表示
    @State private var isShowSetting = false         // 設定画面表示
    
    // MARK: - Glid Layout
    
    private var gridItemWidth: CGFloat {
        return CGFloat(DeviceSizeManager.deviceWidth / 3) - 10
    }
    
    private var gridColumns: [GridItem] {
        Array(repeating: GridItem(.fixed(gridItemWidth)), count: 3)
    }
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView()
                
                ScrollView {
                    LazyVGrid(columns: gridColumns) {
                        
                        ForEach(repository.lives) { live in
                            
                            NavigationLink {
                                DetailLiveView(live: live)
                            } label: {
                                Text(live.artist)
                            }
                        }
                        
                    }
                }.scrollContentBackground(.hidden)
                    .background(Asset.Colors.foundationColor.swiftUIColor)
            }
            
            
            FooterView()
            
            
        }.background(Asset.Colors.foundationColor.swiftUIColor)
            .onAppear {
                repository.readAllLive()
            }
        
    }
}

#Preview {
    ArtistGridListView()
}
