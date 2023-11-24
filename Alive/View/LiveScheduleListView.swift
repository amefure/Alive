//
//  LiveListView.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import SwiftUI
import PhotosUI
import RealmSwift

struct LiveScheduleListView: View {
    
    private let dateFormatManager = DateFormatManager()
    
    // MARK: - ViewModel
    private let userDefaultsRepository = UserDefaultsRepositoryViewModel.sheard
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // MARK: - View
    @State private var search:String = ""            // 検索テキスト
    @State private var isShowInput = false           // Input画面表示
    @State private var isShowSetting = false         // 設定画面表示
    
    private var filteringLives: [Live]{
        repository.lives.filter { $0.date >= Calendar.current.startOfDay(for: Date()) }.reversed()
    }
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView()
                
                Text("NEXT LIVE")
                    .fontWeight(.bold)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        if filteringLives.count != 0 {
                            ForEach(filteringLives) { live in
                                NavigationLink {
                                    DetailLiveView(live: live)
                                } label: {
                                    CardLiveView(live: live)
                                }
                            }
                        } else {
                            CardLiveView(live: Live.blankLive)
                        }
                        
                    }.padding(.horizontal, 20)
                }
                
                Text("LIVE HISTORY")
                    .fontWeight(.bold)
                LiveHistoryBlockView(array: repository.generateAvailability)
                
                Text("LIVE LIST")
                    .fontWeight(.bold)
                
                List {
                    ForEach(repository.lives) { live in
                        NavigationLink {
                            DetailLiveView(live: live)
                        } label: {
                            HStack {
                                
                                VStack(spacing: 0) {
                                    Spacer()
                                    MonthAndDayView(month: dateFormatManager.getMouthAndDayString(date: live.date).0, day: dateFormatManager.getMouthAndDayString(date: live.date).1, size: 40)
                                    Spacer()
                                }.frame(width: 55, height: 55)
                                .background(live.type.color)
                                    .clipShape(RoundedRectangle(cornerRadius: 55))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 55)
                                            .stroke(.white, lineWidth: 2)
                                    ).padding(2)
                                   
                                
//                                Text(dateFormatManager.getDayOfWeekString(date: live.date))
                               
                                VStack(spacing: 0) {
                                    HStack {
                                        Image(systemName: "music.mic")
                                        Text(live.artist)
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Image(systemName: "mappin.and.ellipse")
                                        Text(live.venue)
                                        Spacer()
                                    }
                                }
                                Spacer()
                            }
                        }//.padding(.vertical, 3)
                        .listRowBackground(Asset.Colors.themaYellow.swiftUIColor)
                        .foregroundStyle(.foundation)
                        .foregroundStyle(.foundation)
                            .fontWeight(.bold)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }.scrollContentBackground(.hidden)
                    .background(.foundation)
                    .padding(.bottom, 40)
            }
            
            
            FooterView()
            
            
        }.background(.foundation)
            .onAppear {
                repository.readAllLive()
            }.tint(.themaYellow)
        
    }
}


struct LiveHistoryBlockView: View {
    
    public var array: [ObjectId?]
    private let grids = Array(repeating: GridItem(.fixed(DeviceSizeManager.deviceWidth / 14)), count: 3)
    private let size = DeviceSizeManager.deviceWidth / 14
    private let dateFormatManager = DateFormatManager()
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    var body: some View {
        VStack {
            
            HStack {
                Text(dateFormatManager.getShortString(date: Calendar.current.date(byAdding: .day, value: -30, to: Date())!))
                    .font(.caption)
                Spacer()
                Text(dateFormatManager.getShortString(date: Date()))
                    .font(.caption)
            }
            LazyHGrid(rows: grids) {
                ForEach((0...29), id: \.self) { num in
                    if let value = array[safe: num] {
                        if value != nil {
                            NavigationLink {
                                if let live = repository.lives.first(where: { $0.id == value }) {
                                    DetailLiveView(live: live)
                                }
                            } label: {
                                Text("")
                                    .frame(width:size,height: size)
                                    .background(.themaYellow)
                                    .clipShape(RoundedRectangle(cornerRadius: 3))
                            }

                        }else {
                            Text("")
                                .frame(width:size,height: size)
                                .background(.opacityGray)
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                        }
                    }
                }
            }
        }.padding()
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal)
    }
}

#Preview {
        LiveScheduleListView()
//    NextLiveView(live: Live.demoLive)
}
