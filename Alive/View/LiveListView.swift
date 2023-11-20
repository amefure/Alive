//
//  LiveListView.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import SwiftUI
import PhotosUI

struct LiveListView: View {
    
    // MARK: - Utility
    private let imageFileManager = ImageFileManager()
    
    // MARK: - ViewModel
    private let userDefaultsRepository = UserDefaultsRepositoryViewModel.sheard
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // MARK: - View
    @State private var search:String = ""            // 検索テキスト
    @State private var selectedGroup: String = "All" // 選択されているグループ値
    @State private var isShowInput = false           // Input画面表示
    @State private var isShowSetting = false         // 設定画面表示
    
    var body: some View {
        VStack {
            
            
            List {
                ForEach(repository.lives) { live in
                    
                    NavigationLink {
                        DetailLiveView(live: live)
                    } label: {
                        Text("")
                    }
                }
            }.listStyle(.grouped)
                .scrollContentBackground(.hidden)
                .background(.clear)
                .offset(y: -20)
            
            
   
            
        }
    }
    
}



#Preview {
    LiveListView()
}
