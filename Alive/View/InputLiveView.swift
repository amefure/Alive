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
    @State private var artist: String = ""             // アーティスト
    @State private var name: String = ""               // ライブ名
    @State private var date: Date = Date()             // 開催日
    @State private var openingTime: Date?              // 開催日
    @State private var performanceTime: Date?          // 開催日
    @State private var closingTime: Date?              // 開催日
    @State private var venue: String = ""              // 開催地
    @State private var price: String = ""              // チケット代
    @State private var liveType: LiveType = .unknown   // メモ
    @State private var memo: String = ""               // メモ
    
    @State private var image: UIImage?                  // 画像表示用
    @State private var isShowImagePicker: Bool = false  // 画像ピッカー表示
    
    @State private var successAlert: Bool = false       // 登録成功アラート
    @State private var validationAlert: Bool = false    // バリデーションアラート
    @State private var validationUrlAlert: Bool = false // バリデーションURLアラート
    
    @Environment(\.dismiss) var dismiss
    
    private func setLiveData() {
        if let live = live {
            artist = live.artist
            name = live.name
            date = live.date
            openingTime = live.openingTime
            performanceTime = live.performanceTime
            closingTime = live.closingTime
            venue = live.venue
            price = String(live.price)
            memo = live.memo
        }
    }
    
    
    var body: some View {
        VStack {
            
            HeaderView(leadingIcon: "chevron.backward", trailingIcon: "checkmark", leadingAction: { dismiss() }, trailingAction: {
                
                /// 必須入力事項チェック
                guard !artist.isEmpty else {
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
                            .frame(width: DeviceSizeManager.deviceWidth, height: 200)
                            .foregroundStyle(.white)
                            .background(.opacityGray)
                    }
                }.padding(.top, 20)
                
                
                VStack(alignment: .leading) {
                    Text(L10n.liveArtist)
                    TextField(L10n.liveArtist, text: $artist)
                        .textFieldStyle(.roundedBorder)
                }.padding()
                
                VStack(alignment: .leading) {
                    Text(L10n.liveName)
                    TextField(L10n.liveName, text: $name)
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
                    .accentColor(.themaYellow)
                    
                }.padding()
                
                
                TimePicker(selectedTime: $openingTime, title:L10n.liveOpeningTime)
                
                TimePicker(selectedTime: $performanceTime, title:L10n.livePerformanceTime)
                
                TimePicker(selectedTime: $closingTime, title:L10n.liveClosingTime)
                
            }
            Spacer()
            
            
        }.navigationBarBackButtonHidden()
            .navigationBarHidden(true)
            .fontWeight(.bold)
            .background(.foundation)
            .onAppear {
                setLiveData()
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

struct TimePicker: View {
    
    @Binding var selectedTime: Date?
    public let title: String
    
    private let dateFormatManager = DateFormatManager()
    
    @State private var hour: Int = 0
    @State private var minute: Int = 0
    private let hours = Array(0...23)
    private let minutes = Array(0...60)
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            Text(title)
            
            Spacer()
            
            Menu {
                ForEach(hours, id: \.self) { hour in
                    Button {
                        self.hour = hour
                    } label: {
                        Text("\(hour)")
                    }
                }
            } label: {
                Text("\(hour)")
                    .padding()
                    .frame(width: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.white, lineWidth: 1)
                    )
            }
            
            Text("：")
            
            Menu {
                ForEach(minutes, id: \.self) { minute in
                    Button {
                        self.minute = minute
                    } label: {
                        Text(minute < 10 ? "0\(minute)" :  "\(minute)")
                    }
                }
            } label: {
                Text(minute < 10 ? "0\(minute)" :  "\(minute)")
                    .padding()
                    .frame(width: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.white, lineWidth: 1)
                    )
            }
            
            Spacer()
            
        }.foregroundStyle(.white)
            .onChange(of: hour) { _ in
                selectedTime = dateFormatManager.getDate(hour: hour, minute: minute)
            }
            .onChange(of: minute) { _ in
                selectedTime = dateFormatManager.getDate(hour: hour, minute: minute)
            }
            .onAppear {
                if let time = selectedTime {
                    let timeStr = dateFormatManager.getTimeString(date: time)
                    hour = String(timeStr.prefix(2)).toNum()
                    minute = String(timeStr.suffix(2)).toNum()
                }
            }
    }
}

#Preview {
    InputLiveView(live: Live.demoLive)
}
