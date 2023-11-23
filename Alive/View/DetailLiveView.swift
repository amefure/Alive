//
//  DetailLiveView.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import SwiftUI

struct DetailLiveView: View {
    
    // MARK: - Utility
    private let dateFormatManager = DateFormatManager()
    private let imageFileManager = ImageFileManager()
    
    // MARK: - ViewModel
    private let userDefaultsRepository = UserDefaultsRepositoryViewModel.sheard
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    @ObservedObject private var interstitial = AdmobInterstitialView()
    
    init(live: Live) {
        self.live = live
    }
    
    // MARK: - Receive
    var live: Live
    
    // MARK: - View
    @State private var isShowInput = false
    @State private var isDeleteDialog = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            HeaderView(leadingIcon: "chevron.backward", trailingIcon: "pencil", leadingAction: { dismiss() }, trailingAction: {
                isShowInput = true
            }, isShowLogo: live.imagePath != "")
            .tint(.themaYellow)
            ScrollView {
                
                LiveImageView(image: imageFileManager.loadImage(name: live.imagePath))
                
                Text("「 " + live.name + " 」")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Rectangle()
                    .frame(width: DeviceSizeManager.deviceWidth, height: 2)
                    .background(.themaYellow)
                    .padding(.bottom, 8)
                
                
                HStack {
                    
                    if live.type != .unknown {
                        Text(live.type.value)
                            .padding(5)
                            .background(live.type.color)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .padding(.leading, 20)
                    }
                    
                    Spacer()
                    Image(systemName: "music.mic")
                    Text(live.artist)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .padding(.trailing, 20)
                }
                
                
                //                ScrollView(.horizontal, showsIndicators: false) {}
                
                HStack {
                    
                    
                    VStack {
                        
                        
                        HStack {
                            Image(systemName: "bolt.fill")
                                .padding(.leading, 10)
                            Text("Live情報")
                            Spacer()
                        } .padding(.top , 10)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            
                            if live.venue != "" {
                                HStack {
                                    Image(systemName: "mappin.and.ellipse")
                                        .padding(.leading, 10)
                                        .frame(width: 30)
                                    Text(L10n.liveVenue + "：")
                                    Text(live.venue)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                            }
                            
                            if live.price != -1 {
                                HStack {
                                    Image(systemName: "banknote")
                                        .padding(.leading, 10)
                                        .frame(width: 30)
                                    Text(L10n.livePrice + "：")
                                    Text("\(live.price)円")
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                
                            }
                            
                            HStack {
                                Image(systemName: "calendar")
                                    .padding(.leading, 10)
                                    .frame(width: 30)
                                Text(L10n.liveDate + "：")
                                Text(dateFormatManager.getString(date: live.date))
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            
                            if live.openingTime != nil || live.performanceTime != nil || live.closingTime != nil {
                                HStack {
                                    if let openingTime = live.openingTime {
                                        HStack {
                                            Text(L10n.liveOpeningTime + "：")
                                            Text(dateFormatManager.getTimeString(date: openingTime))
                                                .fontWeight(.bold)
                                        }
                                        
                                        Spacer()
                                    }
                                    
                                    if let performanceTime = live.performanceTime {
                                        HStack {
                                            Text(L10n.livePerformanceTime + "：")
                                            Text(dateFormatManager.getTimeString(date: performanceTime))
                                                .fontWeight(.bold)
                                        }
                                        
                                        Spacer()
                                    }
                                    
                                    if let closingTime = live.closingTime {
                                        HStack {
                                            Text(L10n.liveClosingTime + "：")
                                            Text(dateFormatManager.getTimeString(date: closingTime))
                                                .fontWeight(.bold)
                                        }
                                        
                                        Spacer()
                                    }
                                }.padding(.leading, 10)
                            }
                            
                        }
                        .frame(width: DeviceSizeManager.deviceWidth - 20)
                        .padding(.vertical)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.white, lineWidth: 1)
                            
                        )
                        
                    }
                }
                
                
                VStack {
                    HStack {
                        Image(systemName: "note")
                            .padding(.leading, 10)
                        Text(L10n.liveMemo)
                        Spacer()
                    } .padding(.top , 10)
                    
                    Text(live.memo)
                        .frame(width: DeviceSizeManager.deviceWidth - 20)
                        .padding(.vertical)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.white, lineWidth: 1)
                        )
                }
                
                
                if live.type == .festival {
                    VStack {
                        HStack {
                            Image(systemName: "music.note.list")
                                .padding(.leading, 10)
                            Text(L10n.liveTimeTable)
                            Spacer()
                        } .padding(.top , 10)
                        
                        Text(live.memo)
                            .frame(width: DeviceSizeManager.deviceWidth - 20)
                            .padding(.vertical)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.white, lineWidth: 1)
                            )
                    }
                } else {
                    SwitchInputEditorView(live: live)
                }
                
                Button {
                    isDeleteDialog = true
                } label: {
                    Text(L10n.deleteButtonTitle)
                        .padding(.vertical, 7)
                        .frame(width: 100)
                        .foregroundStyle(.themaYellow)
                        .overlay{
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(style: StrokeStyle(lineWidth: 1))
                                .frame(width: 100)
                                .foregroundStyle(.themaYellow)
                        }.padding(.top , 20)
                }
                
            }.padding(.bottom)
            
            Spacer()
        }.navigationBarBackButtonHidden()
            .navigationBarHidden(true)
            .background(.foundation)
            .sheet(isPresented: $isShowInput, content: {
                InputLiveView(live: live)
            })
            .alert(L10n.deleteButtonAlertTitle, isPresented: $isDeleteDialog) {
                Button(role: .destructive) {
                    repository.deleteLive(id: live.id)
                    dismiss()
                } label: {
                    Text(L10n.deleteButtonTitle)
                }
            }
    }
}


struct SwitchInputEditorView: View {
    
    public var live: Live
    
    @State var isEdit: Bool = false
    @State var text: String = ""
    
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "music.note.list")
                    .padding(.leading, 10)
                Text(L10n.liveSetlist)
                Spacer()
                

                Button {
                    if isEdit {
                        let newLive = Live()
                        newLive.artist = live.artist
                        newLive.name = live.name
                        newLive.date = live.date
                        newLive.openingTime = live.openingTime
                        newLive.performanceTime = live.performanceTime
                        newLive.closingTime = live.closingTime
                        newLive.venue = live.venue
                        newLive.price = live.price
                        newLive.type = live.type
                        newLive.memo = live.memo
                        newLive.setList = text
                        newLive.imagePath = live.imagePath
                        print(newLive.setList)
                        repository.updateLive(id: live.id, newLive: newLive)
                    }
                    isEdit.toggle()
                } label: {
                    Image(systemName: "plus")
                        .padding(.trailing, 10)
                }

            } .padding(.top , 10)
            
            if isEdit {
                TextEditor(text: $text)
                    .padding()
                    .frame(width: DeviceSizeManager.deviceWidth - 20, height: 150)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white, lineWidth: 1)
                    ).scrollContentBackground(.hidden)
                    .background(.foundation)
            } else {
                ScrollView {
                
                    HStack {
                        Text(live.setList)
                    
                    Spacer()
                    }
                }.padding()
                    .frame(width: DeviceSizeManager.deviceWidth - 20, height: 150)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white, lineWidth: 1)
                    )
            }
        }.onAppear {
            print( live.setList)
            text = live.setList
            print( text)
        }
    }
}


#Preview {
    DetailLiveView(live: Live.demoLive)
}
