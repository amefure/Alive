//
//  LiveListView.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import SwiftUI
import PhotosUI

struct LiveScheduleListView: View {
    
    private let dateFormatManager = DateFormatManager()
    
    // MARK: - ViewModel
    private let userDefaultsRepository = UserDefaultsRepositoryViewModel.sheard
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // MARK: - View
    @State private var search:String = ""            // 検索テキスト
    @State private var isShowInput = false           // Input画面表示
    @State private var isShowSetting = false         // 設定画面表示
    
    
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView()
                
                LiveHistoryBlockView(array: repository.generateAvailability)
                
                HStack {
                    Button {
                        
                    } label: {
                        Text("Schedule")
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Artist")
                    }
                    
                }
                List {
                    ForEach(repository.lives) { live in
                        NavigationLink {
                            DetailLiveView(live: live)
                        } label: {
                            HStack {
                                Text(dateFormatManager.getShortString(date: live.date))
                                Text(dateFormatManager.getDayOfWeekString(date: live.date))
                                Text(live.artist)
                                Text(live.venue)
                            }
                            
                        }
                    }
                }.listStyle(.grouped)
                    .scrollContentBackground(.hidden)
                    .background(.foundation)
            }
            
            
            FooterView()
            
            
        }.background(.foundation)
            .onAppear {
                repository.readAllLive()
            }.tint(.themaYellow)
        
    }
}

struct LiveHistoryBlockView: View {
    
    public var array: [Bool]
    private let grids = Array(repeating: GridItem(.fixed(DeviceSizeManager.deviceWidth / 14)), count: 3)
    private let size = DeviceSizeManager.deviceWidth / 14
    private let dateFormatManager = DateFormatManager()
    
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
                    if array[safe: num] ?? false {
                        Text("")
                            .frame(width:size,height: size)
                            .background(.themaYellow)
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                    } else {
                        Text("")
                            .frame(width:size,height: size)
                            .background(.opacityGray)
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                    }
                }
            }
        }.padding()
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding()
    }
}

#Preview {
    LiveScheduleListView()
}
