//
//  MainView.swift
//  Alive
//
//  Created by t&a on 2023/11/25.
//

import SwiftUI
import RealmSwift

struct MainView: View {
    private let dateFormatManager = DateFormatManager()
    
    // MARK: - ViewModel
    private let userDefaultsRepository = UserDefaultsRepositoryViewModel.sheard
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // MARK: - View
    @State private var search: String = ""            // 検索テキスト
    @State private var isShowInput = false           // Input画面表示
    @State private var isShowSetting = false         // 設定画面表示
    
    private var filteringLives: [Live]{
        repository.lives.filter { $0.date >= Calendar.current.startOfDay(for: Date()) }.reversed()
    }
    @Binding var selectedTab: Int
    
    var body: some View {

            VStack {

                Text("NEXT LIVE")
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                
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
                    .padding(.vertical, 10)
                
                LiveHistoryBlockView(array: repository.getMonthLiveHistory)
                
                HStack {
                    
                   Spacer()
                        .frame(width: 80)
                        .padding(.leading, 10)
                        .padding(.top, 20)

                    Spacer()
                    
                    Text("LIVE LIST")
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    Spacer()
                    
                    Button {
                        selectedTab = 3
                    } label: {
                        HStack {
                            Text("ALL")
                            Image(systemName: "arrow.forward")
                        }.padding(5)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .fontWeight(.bold)
                        
                    }.frame(width: 80)
                        .padding(.trailing, 10)
                        .padding(.top, 20)

                }
                
                // prefixだとSliceになってしまう
                LiveScheduleListView(lives: repository.lives.reversed().suffix(5).reversed())

            
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
    MainView(selectedTab: Binding.constant(1))
}
