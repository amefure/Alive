//
//  InputLiveView.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import SwiftUI


struct InputLiveView: View {
    
    // MARK: - Utility
    private let imageFileManager = ImageFileManager()
    
    // MARK: - ViewModel
    private let userDefaultsRepository = UserDefaultsRepositoryViewModel.sheard
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // Updateデータ受け取り用
    public var live: Live?
    
    init(live: Live?) {
        self.live = live
    }
    
    // MARK: - View
    @State private var artist: String = ""           // アーティスト
    @State private var date: Date = Date()           // 開催日
    @State private var venue: String = ""            // 開催地
    @State private var price: String = ""             // 料金
    @State private var memo: String = ""             // メモ
    

    
    @State private var successAlert: Bool = false       // 登録成功アラート
    @State private var validationAlert: Bool = false    // バリデーションアラート
    @State private var validationUrlAlert: Bool = false // バリデーションURLアラート
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack {
            
            
            VStack {
                
                HeaderView(leadingIcon: "chevron.backward", trailingIcon: "checkmark", leadingAction: { dismiss() }, trailingAction: {
                    
                    /// 必須入力事項チェック
                    guard !artist.isEmpty else {
                        validationAlert = true
                        return
                    }
                    
                    if let live = live {
                        
                        /// 更新処理
                        repository.updateLive(
                            id: live.id,
                            artist: artist,
                            date: date,
                            venue: venue,
                            price: price.toNum(),
                            memo: memo)
                        
                    } else {
                        /// 新規登録
                        repository.createLive(
                            artist: artist,
                            date: date,
                            venue: venue,
                            price: price.toNum(),
                            memo: memo)
                    }
                    
                    successAlert = true
                    
                }, isShowLogo: false)
                .padding(.top, 30)
                .tint(.white)
                
                Spacer()
                
                TextField(L10n.liveArtist, text: $artist)
                    .textFieldStyle(.roundedBorder)
                
                
                TextField(L10n.liveVenue, text: $venue)
                    .textFieldStyle(.roundedBorder)
                
                TextField(L10n.livePrice, text: $price)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                TextField(L10n.liveMemo, text: $memo)
                    .textFieldStyle(.roundedBorder)
                
                DatePicker(selection: $date,
                                      displayedComponents: DatePickerComponents.date,
                                      label: { Text(L10n.liveDate) })
                           .environment(\.locale, Locale(identifier: L10n.dateLocale))
                           .environment(\.calendar, Calendar(identifier: .gregorian))
                           .datePickerStyle(.graphical)
                           .accentColor(Asset.Colors.themaOrangeColor.swiftUIColor)
                
                Spacer()
                
            }
        
                    
          
        }.navigationBarBackButtonHidden()
            .navigationBarHidden(true)
            .background(Asset.Colors.foundationColor.swiftUIColor)
            
    }
}

#Preview {
    InputLiveView(live: Live.demoLive)
}
