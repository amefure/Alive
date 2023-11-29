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
    private let dateFormatManager = DateFormatManager()
    
    // MARK: - ViewModel
    private let userDefaultsRepository = UserDefaultsRepositoryViewModel.sheard
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // Updateデータ受け取り用
    public var live: Live?
    
    init(live: Live?) {
        self.live = live
    }
    
    // MARK: - View
    @State private var artist: String = ""             // アーティスト
    @State private var name: String = ""               // ライブ名
    @State private var date: Date = Date()             // 開催日
    @State private var openingTime: Date?              // 開催日
    @State private var performanceTime: Date?          // 開催日
    @State private var closingTime: Date?              // 開催日
    @State private var venue: String = ""              // 開催地
    @State private var price: String = ""              // チケット代
    @State private var liveType: LiveType = .unknown   // ライブ形式
    @State private var memo: String = ""               // メモ

    // Pool
    @State private var image: UIImage?                  // 画像表示用
    
    // Show
    @State private var isShowImagePicker: Bool = false  // 画像ピッカー表示
    @State private var isShowCalendar: Bool = false     // カレンダー表示
    
    // Alert
    @State private var successAlert: Bool = false       // 登録成功アラート
    @State private var validationAlert: Bool = false    // バリデーションアラート
    
    // Environment
    @Environment(\.dismiss) var dismiss
    
    // 画面描画時に入力UIとデータを紐づける
    private func setLiveData() {
        if let live = live {
            artist = live.artist
            name = live.name
            date = live.date
            openingTime = live.openingTime
            performanceTime = live.performanceTime
            closingTime = live.closingTime
            venue = live.venue
            liveType = live.type
            if live.price != -1 {
                price = String(live.price)
            }
            memo = live.memo
            image = imageFileManager.loadImage(name: live.imagePath)
        }
    }
    
    
    var body: some View {
        VStack {
            
            HeaderView(leadingIcon: "chevron.backward", trailingIcon: "checkmark", leadingAction: { dismiss() }, trailingAction: {
                
                /// 必須入力事項チェック
                guard !artist.isEmpty && !name.isEmpty else {
                    validationAlert = true
                    return
                }
                
                if let live = live {
                    
                    var imgName = live.imagePath
                    
                    if imgName == "" {
                        imgName = UUID().uuidString   // 画像のファイル名を構築
                    }
                    
                    if let image = image {
                        let result = imageFileManager.saveImage(name: imgName, image: image)
                        if result {
                            print("保存成功")
                        }
                    }
                    
                    let newLive = Live()
                    newLive.artist = artist
                    newLive.name = name
                    newLive.date = date
                    newLive.openingTime = openingTime
                    newLive.performanceTime = performanceTime
                    newLive.closingTime = closingTime
                    newLive.venue = venue
                    newLive.price = price.toNum()
                    newLive.type = liveType
                    newLive.memo = memo
                    newLive.imagePath = imgName
                    newLive.setList = live.setList
                    /// 更新処理
                    repository.updateLive(id: live.id, newLive: newLive)
                    
                } else {
                    /// 新規登録
                    var imgName = ""
                    
                    /// 画像がセットされていれば画像を表示
                    if let image = image {
                        imgName = UUID().uuidString   // 画像のファイル名を構築
                        let result = imageFileManager.saveImage(name: imgName, image: image)
                        if result {
                            print("保存成功")
                        }
                    }
                    
                    let newLive = Live()
                    newLive.artist = artist
                    newLive.name = name
                    newLive.date = date
                    newLive.openingTime = openingTime
                    newLive.performanceTime = performanceTime
                    newLive.closingTime = closingTime
                    newLive.venue = venue
                    newLive.price = price.toNum()
                    newLive.type = liveType
                    newLive.memo = memo
                    newLive.imagePath = imgName
                    /// 新規登録
                    repository.createLive(newLive: newLive)
                    
                }
                
                successAlert = true
                
            }, isShowLogo: false)
            .padding(.top, 30)
            .tint(.themaYellow)
            
            Spacer()
            
            ScrollView(showsIndicators: false) {
                
                ZStack {
                    LiveImageView(image: image)
                    
                    Button {
                        isShowImagePicker = true
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: DeviceSizeManager.deviceWidth, height: 180)
                            .foregroundStyle(.white)
                            .background(.opacityGray)
                    }
                }.padding(.top, 20)
                
                VStack {
                    Text(L10n.liveType)
                    Divider()
                    HStack(spacing: 20) {
                        ForEach(LiveType.allCases, id: \.self) { item in
                            
                            if item != .unknown {
                                Button {
                                    liveType = item
                                } label: {
                                    Text(item.value)
                                }.foregroundStyle(liveType == item ? .foundation : .white)
                                    .padding()
                                    .frame(width: 100)
                                    .background(liveType == item ? item.color : .opacityGray)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(.white, lineWidth: 1)
                                    )
                            }
                        }
                    }
                }
                
                // MARK: - アーティスト
                HStack {
                    Image(systemName: "music.mic")
                        .foregroundStyle(.black)
                        .frame(width: 23)
                    TextField(liveType != .oneman ? L10n.liveMainArtist : L10n.liveArtist, text: $artist)
                    
                    Spacer()
                    
                    if repository.artists.count != 0 {
                        Menu {
                            ForEach(repository.artists, id: \.self) { artist in
                                Button {
                                    self.artist = artist
                                } label: {
                                    Text(artist)
                                }
                            }
                        } label: {
                            Image(systemName: "chevron.up.chevron.down")
                                .font(.system(size: 13))
                                .foregroundStyle(.foundation)
                        }
                    }
                    
                }.padding(DeviceSizeManager.isSESize ? 10 : 15)
                    .background(.regularMaterial)
                    .environment(\.colorScheme, .light)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(DeviceSizeManager.isSESize ? 10 : 15)
                
                // MARK: - ライブ名
                CustomInputView(text: $name, imgName: "bolt.fill", placeholder: L10n.liveName)
                
                // MARK: - 会場
                CustomInputView(text: $venue, imgName: "mappin.and.ellipse", placeholder: L10n.liveVenue)
                
                // MARK: - チケット代
                CustomInputView(text: $price, imgName: "banknote", placeholder: L10n.livePrice)
                    .keyboardType(.numberPad)
                
                // MARK: - 開催日
                HStack {
                    Image(systemName: "calendar")
                        .foregroundStyle(.black)
                        .frame(width: 23)
                    
                    Button {
                        isShowCalendar.toggle()
                    } label: {
                        Text(L10n.liveDate)
                        Text(dateFormatManager.getString(date: date))
                        Image(systemName: isShowCalendar ? "checkmark" : "chevron.up.chevron.down")
                    }.foregroundStyle(.opacityGray)
                    
                    
                    Spacer()
                }.padding(DeviceSizeManager.isSESize ? 10 : 15)
                    .background(.regularMaterial)
                    .environment(\.colorScheme, .light)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(DeviceSizeManager.isSESize ? 10 : 15)
                
                if isShowCalendar {
                    VStack(alignment: .leading) {
                        Text(L10n.liveDate)
                        Divider()
                        DatePicker(selection: $date,
                                   displayedComponents: DatePickerComponents.date,
                                   label: { Text(L10n.liveDate) })
                        .environment(\.locale, Locale(identifier: L10n.dateLocale))
                        .environment(\.calendar, Calendar(identifier: .gregorian))
                        .datePickerStyle(.graphical)
                        .accentColor(.themaYellow)
                        
                    }.padding()
                }
                
                // MARK: - 開場時間
                TimePicker(selectedTime: $openingTime, title:L10n.liveOpeningTime)
                
                // MARK: - 開演時間
                TimePicker(selectedTime: $performanceTime, title:L10n.livePerformanceTime)
                
                // MARK: - 終了時間
                TimePicker(selectedTime: $closingTime, title:L10n.liveClosingTime)
                
                // MARK: - MEMO
                CustomInputEditorView(text: $memo,  imgName: "note", placeholder: L10n.liveMemo)
                
            }
            Spacer()
            
            
        }.navigationBarBackButtonHidden()
            .navigationBarHidden(true)
            .fontWeight(.bold)
            .background(.foundation)
            .onAppear {
                setLiveData()
            }.alert(live == nil ? L10n.entrySuccessAlertTitle : L10n.updateSuccessAlertTitle, isPresented: $successAlert) {
                Button("OK") {
                    dismiss()
                }
            }
            .alert(L10n.validationAlertTitle, isPresented: $validationAlert) {
                Button("OK") {
                }
            }
            .sheet(isPresented: $isShowImagePicker) {
                ImagePickerDialog(image: $image)
            }
        
    }
}

// MARK: - Editor入力要素
struct CustomInputEditorView: View {
    
    // MARK: - Receive
    @Binding var text: String
    public var imgName: String
    public var placeholder: String
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: imgName)
                    .frame(width: 23)
                
                Text(placeholder)
                    .font(.system(size: 13))
                    .fontWeight(.bold)
                    .padding(.leading, 5)
                Spacer()
            }
            
            TextEditor(text: $text)
                .frame(height: 100)
                .padding()
                .scrollContentBackground(.hidden)
                .background(Color(red: 1, green: 1, blue: 1, opacity:0.7))
                .environment(\.colorScheme, .light)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
        }.padding(.horizontal)
    }
}



#Preview {
    InputLiveView(live: Live.demoLive)
}
