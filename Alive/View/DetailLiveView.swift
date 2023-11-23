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
    @State private var isDeleteTimeTableDialog = false
    
    @State private var isModal = false
    @Environment(\.dismiss) var dismiss
    
    @State private var deleteTimeTable: TimeTable? = nil
    
    var body: some View {
        VStack {
            
            HeaderView(leadingIcon: "chevron.backward", trailingIcon: "pencil", leadingAction: { dismiss() }, trailingAction: {
                isShowInput = true
            }, isShowLogo: live.imagePath != "")
            .tint(.themaYellow)
            
            ScrollView {
                
                LiveImageView(image: imageFileManager.loadImage(name: live.imagePath))
                
                CardLiveView(live: live)
                
                
                HStack {
                    
                    Spacer()
                    
                    VStack {
                        Text(L10n.liveType)
                            .foregroundStyle(.themaYellow)
                            .font(.system(size: 12))
                        Text(live.type.value)
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                        
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text(L10n.livePrice)
                            .foregroundStyle(.themaYellow)
                            .font(.system(size: 12))
                        Text(live.price == -1 ? "ー 円" : "\(live.price)円")
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                    }
                    
                    Spacer()
                    
                    
                    VStack {
                        Text(L10n.liveDate)
                            .foregroundStyle(.themaYellow)
                            .font(.system(size: 12))
                        Text(dateFormatManager.getYearString(date: live.date))
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                    }
                    
                    Spacer()
                    
                }.padding()
                
                HStack {
                    
                    Spacer()
                    
                    VStack {
                        Text(L10n.liveOpeningTime)
                            .foregroundStyle(.themaYellow)
                            .font(.system(size: 12))
                        if let openingTime = live.openingTime {
                            Text(dateFormatManager.getTimeString(date: openingTime))
                                .foregroundStyle(.white)
                                .font(.system(size: 20))
                        } else {
                            Text("0:00")
                                .foregroundStyle(.white)
                                .font(.system(size: 20))
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text(L10n.livePerformanceTime)
                            .foregroundStyle(.themaYellow)
                            .font(.system(size: 12))
                        if let performanceTime = live.performanceTime {
                            Text(dateFormatManager.getTimeString(date: performanceTime))
                                .foregroundStyle(.white)
                                .font(.system(size: 20))
                        } else {
                            Text("0:00")
                                .foregroundStyle(.white)
                                .font(.system(size: 20))
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text(L10n.liveClosingTime)
                            .foregroundStyle(.themaYellow)
                            .font(.system(size: 12))
                        if let closingTime = live.closingTime {
                            Text(dateFormatManager.getTimeString(date: closingTime))
                                .foregroundStyle(.white)
                                .font(.system(size: 20))
                        } else {
                            Text("0:00")
                                .foregroundStyle(.white)
                                .font(.system(size: 20))
                        }
                    }
                    
                    
                    Spacer()
                    
                }.padding()
                    .fontWeight(.bold)
                
                SideBarTitleView(title: L10n.liveMemo)
                
                
                HStack {
                    Text(live.memo)
                    Spacer()
                }.frame(width: DeviceSizeManager.deviceWidth - 80)
                    .padding()
                    .background(.regularMaterial)
                    .environment(\.colorScheme, .light)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                
                if live.type == .festival {
                    VStack(spacing: 0) {
                        
                        SideBarTitleView(title: L10n.liveTimeTable)
                        
                        ForEach(live.timeTable.sorted(byKeyPath: "time", ascending: true)) { row in
                            HStack {
                                Text(dateFormatManager.getTimeString(date: row.time))
                                Text(row.artist)
                                Text(row.memo)
                                Spacer()
                            }
                            .padding()
                                .background(row.color.color)
                                .onLongPressGesture() {
                                    deleteTimeTable = row
                                    isDeleteTimeTableDialog = true
                                }
                        }
                        
                        Button {
                            isModal = true
                        } label: {
                            Text("ADD TIMETABLE")
                        }
                    }.sheet(isPresented: $isModal) {
                        InputTimeTableView(live: live)
                        .presentationDetents([. medium])
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
            .fontWeight(.bold)
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
            }.alert("\(deleteTimeTable?.artist ?? "")を削除しますか？", isPresented: $isDeleteTimeTableDialog) {
                Button(role: .destructive) {
                    if let deleteTimeTable = deleteTimeTable {
                        repository.deleteTimeTable(id: live.id, timeTable: deleteTimeTable)
                        self.deleteTimeTable = nil
                    }
                } label: {
                    Text(L10n.deleteButtonTitle)
                }
            }
    }
}

struct SideBarTitleView: View {
    public let title: String
    var body: some View {
        HStack {
            
            Spacer()
            
            Rectangle()
                .frame(width: 80, height: 1)
                .foregroundStyle(.themaYellow)
            
            
            Text(title)
                .foregroundStyle(.themaYellow)
                .font(.system(size: 12))
                .padding(.horizontal, 20)
            
            
            Rectangle()
                .frame(width: 80, height: 1)
                .foregroundStyle(.themaYellow)
            
            Spacer()
        }.padding(.vertical)
    }
}


struct SwitchInputEditorView: View {
    
    public var live: Live
    
    @State var isEdit: Bool = false
    @State var text: String = ""
    
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    @FocusState var isActive:Bool
    
    var body: some View {
        VStack {
            
            HStack {
                
                Spacer()
                    .padding(.leading, 20)
                    .frame(width: 80)
                
                Spacer()
                
                Rectangle()
                    .frame(width: 80, height: 1)
                    .foregroundStyle(.themaYellow)
                
                
                Text(L10n.liveSetlist)
                    .foregroundStyle(.themaYellow)
                    .font(.system(size: 12))
                    .padding(.horizontal, 20)
                
                
                Rectangle()
                    .frame(width: 80, height: 1)
                    .foregroundStyle(.themaYellow)
                
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
                        repository.updateLive(id: live.id, newLive: newLive)
                    } else {
                        isActive = true
                    }
                    isEdit.toggle()
                } label: {
                    Text(isEdit ? "保存" : "編集")
                        .padding(.trailing, 20)
                        .frame(width: 80)
                        .foregroundStyle(.themaYellow)
                }
                
            }.padding(.vertical)
            
            
            if isEdit {
                TextEditor(text: $text)
                    .frame(width: DeviceSizeManager.deviceWidth - 80)
                    .frame(minHeight: 150)
                    .padding()
                    .background(.regularMaterial)
                    .environment(\.colorScheme, .light)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .focused($isActive)
                    
            } else {
                HStack {
                    Text(live.setList)
                    Spacer()
                }.frame(width: DeviceSizeManager.deviceWidth - 80)
                    .padding()
                    .background(.regularMaterial)
                    .environment(\.colorScheme, .light)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }.onAppear {
            text = live.setList
        }
    }
}


#Preview {
    DetailLiveView(live: Live.demoLive)
}
