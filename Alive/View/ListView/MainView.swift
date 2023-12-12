//
//  MainView.swift
//  Alive
//
//  Created by t&a on 2023/11/25.
//

import SwiftUI
import RealmSwift

struct MainView: View {
    
    // MARK: - Utility
    private let dateFormatManager = DateFormatManager()
    
    // MARK: - ViewModel
    private let userDefaultsRepository = UserDefaultsRepositoryViewModel.sheard
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // MARK: - Environment
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    
    // MARK: - Binding
    @Binding var selectedTab: Int
    
    // MARK: - View
    // 本日を含む後のライブのみを全て表示
    private var filteringNextLives: [Live] {
        repository.lives.filter { $0.date >= Calendar.current.startOfDay(for: Date()) }.reversed()
    }
    
    // 本日を含まない過去のライブのみを5個のみ表示
//    private var filteringPastLives: [Live] {
//        repository.lives.filter { $0.date <= Calendar.current.startOfDay(for: Date()) }.reversed().suffix(5)
//    }
    
    var body: some View {
        ScrollView {
            
            // MARK: - NEXT LIVE
            Text("NEXT LIVE")
                .fontWeight(.bold)
                .padding(.vertical, DeviceSizeManager.isSESize ? 5 : 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if filteringNextLives.count != 0 {
                        if filteringNextLives.count == 1 , let live = filteringNextLives.first {
                            NavigationLink {
                                DetailLiveView(live: live)
                                    .environmentObject(rootEnvironment)
                            } label: {
                                CardLiveView(live: live)
                                    .padding(.leading, DeviceSizeManager.isSESize ? 15 : 6) // 1つの場合位置調整
                            }
                        } else {
                            ForEach(filteringNextLives) { live in
                                NavigationLink {
                                    DetailLiveView(live: live)
                                        .environmentObject(rootEnvironment)
                                } label: {
                                    CardLiveView(live: live)
                                }
                            }
                        }
                    } else {
                        // 存在しない場合
                        CardLiveView(live: Live.blankLive)
                            .padding(.leading, DeviceSizeManager.isSESize ? 15 : 6) // 1つの場合位置調整
                    }
                }.padding(.horizontal, 20)
            }
            
            // MARK: - LIVE HISTORY
            Text("LIVE HISTORY")
                .fontWeight(.bold)
                .padding(.vertical, DeviceSizeManager.isSESize ? 5 : 10)
            
            LiveHistoryBlockView(array: repository.getMonthLiveHistory)
                .environmentObject(rootEnvironment)
            
            // MARK: - LIVE LIST
            HStack {
                
                Spacer()
                    .frame(width: 80)
                    .padding(.leading, 10)
                    .padding(.top, DeviceSizeManager.isSESize ? 10 : 20)
                
                Spacer()
                
                Text("LIVE LIST")
                    .fontWeight(.bold)
                    .padding(.top, DeviceSizeManager.isSESize ? 10 : 20)
                
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
                    .padding(.top, DeviceSizeManager.isSESize ? 10 : 20)
                
            }
            
            // prefixだとSliceになってしまう
            LiveScheduleListView(lives: repository.lives)
                .environmentObject(rootEnvironment)
                .padding(.horizontal, 10)
                .padding(.bottom, DeviceSizeManager.isSESize ? 30 : 20)
            
        }.background(.foundation)
            .onAppear {
                repository.readAllLive()
            }.tint(.themaYellow)
    }
}


struct LiveHistoryBlockView: View {
    
    // MARK: - Utility
    private let dateFormatManager = DateFormatManager()
    
    // MARK: - Receive
    public var array: [ObjectId?]
    
    // MARK: - ViewModel
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // MARK: - Environment
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    
    // MARK: - View
    private let grids = Array(repeating: GridItem(.fixed(DeviceSizeManager.deviceWidth / 14)), count: 3)
    private let size = DeviceSizeManager.deviceWidth / 14
    
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
                                        .environmentObject(rootEnvironment)
                                }
                            } label: {
                                Text("")
                                    .frame(width: size, height: size)
                                    .background(.themaYellow)
                                    .clipShape(RoundedRectangle(cornerRadius: 3))
                            }
                        }else {
                            Text("")
                                .frame(width: size, height: size)
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
