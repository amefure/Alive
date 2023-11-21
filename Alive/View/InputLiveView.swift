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
    @State private var price: String = ""            // チケット代
    @State private var liveType: LiveType = .unknown // メモ
    @State private var memo: String = ""             // メモ
    

    @State private var image: UIImage?                  // 画像表示用
    @State private var isShowImagePicker: Bool = false  // 画像ピッカー表示
    
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
                            type: liveType,
                            memo: memo)
                        
                    } else {
                        /// 新規登録
                        repository.createLive(
                            artist: artist,
                            date: date,
                            venue: venue,
                            price: price.toNum(),
                            type: liveType,
                            memo: memo)
                    }
                    
                    successAlert = true
                    
                }, isShowLogo: false)
                .padding(.top, 30)
                .tint(Asset.Colors.themaYellowColor.swiftUIColor)
                
                Spacer()
                
                ScrollView(showsIndicators: false) {
                    
                    ZStack {
                        if let image = image {
                            Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(CGSize(width: 3, height: 2), contentMode: .fill)
                                    .frame(width: DeviceSizeManager.deviceWidth, height: 200)
                                    .clipped()
                        } else {
                            Asset.Images.appLogoElectric.swiftUIImage
                                .resizable()
                                .frame(width: 200, height: 200)
                        }
                        
                        Button {
                            isShowImagePicker = true
                        } label: {
                            Image(systemName: "plus")
                                .frame(width: DeviceSizeManager.deviceWidth, height: 200)
                                .foregroundStyle(.white)
                                .background(Asset.Colors.opacityGray.swiftUIColor)
                        }
                    }.padding(.top, 20)

                    
                    VStack(alignment: .leading) {
                        Text(L10n.liveArtist)
                        TextField(L10n.liveArtist, text: $artist)
                            .textFieldStyle(.roundedBorder)
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text(L10n.liveVenue)
                        TextField(L10n.liveVenue, text: $venue)
                            .textFieldStyle(.roundedBorder)
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text(L10n.livePrice)
                        TextField(L10n.livePrice, text: $price)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                    }.padding()
                    
                    
                    VStack(alignment: .leading) {
                        Text(L10n.liveType)
                        Divider()
                        HStack {
                            Spacer()
                            ForEach(LiveType.allCases, id: \.self) { item in
                               
                                if item != .unknown {
                                    Button {
                                        liveType = item
                                    } label: {
                                        Text(item.value)
                                    }.foregroundStyle(liveType == item ? .foundation : .white)
                                        .padding()
                                        .frame(width: 100)
                                        .background(liveType == item ? .themaYellow : .opacityGray)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(.white, lineWidth: 1)
                                        )
                                }
                            }
                            Spacer()
                        }
                    }.padding()
   
                    VStack(alignment: .leading) {
                        Text(L10n.liveMemo)
                        TextField(L10n.liveMemo, text: $memo)
                            .textFieldStyle(.roundedBorder)
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text(L10n.liveDate)
                        Divider()
                        DatePicker(selection: $date,
                                              displayedComponents: DatePickerComponents.date,
                                              label: { Text(L10n.liveDate) })
                                   .environment(\.locale, Locale(identifier: L10n.dateLocale))
                                   .environment(\.calendar, Calendar(identifier: .gregorian))
                                   .datePickerStyle(.graphical)
                                   .accentColor(Asset.Colors.themaYellowColor.swiftUIColor)
                        
                    }.padding()
    
        
                }
                Spacer()
                
            }
          
        }.navigationBarBackButtonHidden()
            .navigationBarHidden(true)
            .fontWeight(.bold)
            .background(Asset.Colors.foundationColor.swiftUIColor)
            .onAppear {
                if let live = live {
                    artist = live.artist
                    date = live.date
                    venue = live.venue
                    price = String(live.price)
                    memo = live.memo
                }
            }.alert(live == nil ? "登録しました。" : "更新しました。", isPresented: $successAlert) {
                Button("OK") {
                    dismiss()
                }
            }
            .sheet(isPresented: $isShowImagePicker) {
                ImagePickerDialog(image: $image)
            }
            
    }
}

#Preview {
    InputLiveView(live: Live.demoLive)
}