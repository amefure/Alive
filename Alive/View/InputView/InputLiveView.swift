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
    @State private var liveType: LiveType = .unknown   // メモ
    @State private var memo: String = ""               // メモ
    
    @State private var image: UIImage?                  // 画像表示用
    @State private var isShowImagePicker: Bool = false  // 画像ピッカー表示
    @State private var isShowCalendar: Bool = false     // 画像ピッカー表示
    
    @State private var successAlert: Bool = false       // 登録成功アラート
    @State private var validationAlert: Bool = false    // バリデーションアラート
    
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
            liveType = live.type
            price = String(live.price)
            memo = live.memo
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
                
                CustomInputView(text: $artist, imgName: "music.mic", placeholder: liveType == .festival ? "一押し" + L10n.liveArtist : L10n.liveArtist)
                
                CustomInputView(text: $name, imgName: "bolt.fill", placeholder: L10n.liveName)
                
                CustomInputView(text: $venue, imgName: "mappin.and.ellipse", placeholder: L10n.liveVenue)
                
                CustomInputView(text: $price, imgName: "banknote", placeholder: L10n.livePrice)
                    .keyboardType(.numberPad)
                
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
                }.padding()
                    .background(.regularMaterial)
                    .environment(\.colorScheme, .light)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                
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
                        .onChange(of: date) { _ in
                            
                        }
                }
                
                TimePicker(selectedTime: $openingTime, title:L10n.liveOpeningTime)
                
                TimePicker(selectedTime: $performanceTime, title:L10n.livePerformanceTime)
                
                TimePicker(selectedTime: $closingTime, title:L10n.liveClosingTime)
                
                CustomInputEditorView(text: $memo,  imgName: "note", placeholder: L10n.liveMemo)
                
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
            .alert("アーティスト名と\nライブ名は必須入力です。", isPresented: $validationAlert) {
                Button("OK") {
                }
            }
            .sheet(isPresented: $isShowImagePicker) {
                ImagePickerDialog(image: $image)
            }
        
    }
}

struct CustomInputView: View {
    
    @Binding var text: String
    public var imgName: String
    public var placeholder: String
    
    
    var body: some View {
        HStack {
            Image(systemName: imgName)
                .foregroundStyle(.black)
                .frame(width: 23)
            TextField(placeholder, text: $text)
        }.padding()
            .background(.regularMaterial)
            .environment(\.colorScheme, .light)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding()
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
            
            Text(title + "時間")
                .padding(.leading, 30)
            
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
            }.padding(.trailing)
            
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
    InputLiveView(live: nil)//Live.demoLive)
}
