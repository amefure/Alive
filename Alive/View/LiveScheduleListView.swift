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
                
                NextLiveView(live: repository.lives.sorted(by: { $0.date < $1.date }).last)
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

struct NextLiveView:View {
    public var live: Live?
    private let imageFileManager = ImageFileManager()
    private let dateFormatManager = DateFormatManager()
    var body: some View {
        if let live = live {

            VStack(spacing:0) {
                    
                    HStack {
                        
                        if let image = imageFileManager.loadImage(name: live.imagePath) {
                            
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .background(.foundation)
                                .clipShape(RoundedRectangle(cornerRadius: 50))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(.white, lineWidth: 3)
                                    
                                ).padding(.leading, 20)
                            
                        } else {
                            Asset.Images.appLogoElectric.swiftUIImage
                                .resizable()
                                .frame(width: 50, height: 50)
                                .background(.foundation)
                                .clipShape(RoundedRectangle(cornerRadius: 50))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(.white, lineWidth: 3)
                                    
                                ).padding(.leading, 20)
                                
                        }
                    
                        
                        Text(live.name)
                            .frame(height: 100)
                            .font(.system(size: 20))
                            .padding(.leading, 20)
                        
                        Spacer()
                        
                    }
                    ZigzagBottomLine()
                        .fill(Color.white)
                        .frame(width: DeviceSizeManager.deviceWidth - 55, height: 1)
                    VStack {
                        HStack {
                            
                            VStack {
                                HStack {
                                    Image(systemName: "music.mic")
                                        .padding(.leading, 20)
                                    Text(live.artist)
                                    Spacer()
                                }
                                
                                HStack {
                                    Image(systemName: "mappin.and.ellipse")
                                        .padding(.leading, 20)
                                    Text(live.venue)
                                    Spacer()
                                }
                            }
                            
                            
                            Text(dateFormatManager.getShortString(date: live.date))
                                .font(.largeTitle)
                                .padding(.trailing, 20)
                        }
                    }.frame(height: 100)
                    .background(Color.white)
                        .foregroundStyle(.foundation)
                        
                    
                }.background(.themaYellow)
                .frame(width: DeviceSizeManager.deviceWidth - 40)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .fontWeight(.bold)

        } else {
            
        }
    }
}


struct ZigzagBottomLine: Shape {
    var zigzagSpacing: CGFloat = 25.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.height))

        for x in stride(from: 0, to: rect.width, by: zigzagSpacing) {
            path.addLine(to: CGPoint(x: x + zigzagSpacing / 2, y: rect.height - zigzagSpacing * 0.3))
            path.addLine(to: CGPoint(x: x + zigzagSpacing, y: rect.height))
        }

        return path
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
//    LiveScheduleListView()
    NextLiveView(live: Live.demoLive)
}
