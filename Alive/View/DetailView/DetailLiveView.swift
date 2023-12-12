//
//  DetailLiveView.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import SwiftUI
import Combine

struct DetailLiveView: View {
    
    // MARK: - Utility
    private let dateFormatManager = DateFormatManager()
    private let imageFileManager = ImageFileManager()
    
    // MARK: - ViewModel
    private let userDefaultsRepository = UserDefaultsRepositoryViewModel.sheard
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    @ObservedObject private var interstitial = AdmobInterstitialView()
    
    // MARK: - Environment
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    
    init(live: Live) {
        self.live = live
    }
    
    // MARK: - Receive
    var live: Live
    
    // MARK: - View
    @State private var isShowInput = false
    @State private var isShowDescDialog = false
    @State private var isDeleteDialog = false
    @State private var isDeleteTimeTableDialog = false
    @State private var isModal = false
    @State private var deleteTimeTable: TimeTable? = nil
    
    @State private var cancellables:Set<AnyCancellable> = Set()
    
    @Environment(\.dismiss) var dismiss
    
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
                    // MARK: - ライブ形式
                    LiveItemView(label: L10n.liveType, value: live.type.value)
   
                    Spacer()
                    // MARK: - チケット代
                    LiveItemView(label: L10n.livePrice, value: live.price == -1 ? L10n.livePriceNone : L10n.livePriceUnit(live.price))
    
                    Spacer()
                    // MARK: - 開催年
                    LiveItemView(label: L10n.liveDateYear, value: dateFormatManager.getYearString(date: live.date))
                    
                    Spacer()
                    
                }.padding()
                
                HStack {
                    
                    Spacer()
                    // MARK: - 開場時間
                    LiveItemView(label: L10n.liveOpeningTime, value: live.openingTime != nil ? dateFormatManager.getTimeString(date: live.openingTime!) : "0:00")
                    
                    Spacer()
                    // MARK: - 開演時間
                    LiveItemView(label: L10n.livePerformanceTime, value: live.performanceTime != nil ? dateFormatManager.getTimeString(date: live.performanceTime!) : "0:00")
                    
                    Spacer()
                    // MARK: - 終了時間
                    LiveItemView(label: L10n.liveClosingTime, value: live.closingTime != nil ? dateFormatManager.getTimeString(date: live.closingTime!) : "0:00")
                    
                    Spacer()
                    
                }.padding()
                    .fontWeight(.bold)
                
                if !live.url.isEmpty , let url = URL(string: live.url) {
                    
                    // MARK: - MEMO
                    SideBarTitleView(title: L10n.liveUrl)
                    
                    Link(destination: url, label: {
                        Text(live.url)
                            .font(.system(size: 20))
                            .textSelection(.enabled)
                            .foregroundStyle(.themaBlue)
                            .underline()
                    }).font(.system(size: 18))
                        .textSelection(.enabled)
                }
                
                // MARK: - MEMO
                SideBarTitleView(title: L10n.liveMemo)
                
                HStack {
                    Text(live.memo)
                        .textSelection(.enabled)
                    Spacer()
                }.frame(width: DeviceSizeManager.deviceWidth - 80)
                    .padding()
                    .background(.regularMaterial)
                    .environment(\.colorScheme, .light)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                // MARK: - セトリ or TimeTable
                if live.type == .festival {
                    // MARK: - TimeTable
                    VStack(spacing: 0) {
                        
                        SideBarTitleView(title: L10n.liveTimeTable, trailingAction: {
                            isShowDescDialog = true
                        }, imgName: "questionmark.circle")
                        .alert(L10n.timetableAlertTitle, isPresented: $isShowDescDialog) {
                            Button("OK") {
                                
                            }
                        }
                        
                        ForEach(live.timeTable.sorted(by: {$0.time < $1.time})) { row in
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
                            Image(systemName: "plus")
                                .foregroundStyle(.themaYellow)
                                .padding()
                                .frame(width: DeviceSizeManager.deviceWidth)
                                .overlay(
                                    Rectangle()
                                        .stroke(.white, lineWidth: 1)
                                )
                        }
                    }.sheet(isPresented: $isModal) {
                        InputTimeTableView(live: live)
                            .presentationDetents([. medium])
                    }
                } else {
                    // MARK: - セトリ
                    SwitchInputEditorView(live: live)
                }
                
                // MARK: - セトリ
                Button {
                    isDeleteDialog = true
                } label: {
                    Text(L10n.deleteButtonTitle)
                        .padding(.vertical, 7)
                        .frame(width: 100)
                        .foregroundStyle(.themaRed)
                        .overlay{
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(style: StrokeStyle(lineWidth: 1))
                                .frame(width: 100)
                                .foregroundStyle(.themaRed)
                        }.padding(.top , 20)
                }
                
            }
            
            AdMobBannerView()
                .frame(height: 60)
            
            Spacer()
            
        }.navigationBarBackButtonHidden()
            .navigationBarHidden(true)
            .fontWeight(.bold)
            .background(.foundation)
            .sheet(isPresented: $isShowInput, content: {
                InputLiveView(live: live)
                    .environmentObject(rootEnvironment)
            })
            .alert(L10n.deleteLiveAlertTitle, isPresented: $isDeleteDialog) {
                Button(role: .destructive) {
                    if !live.imagePath.isEmpty {
                        imageFileManager.deleteImage(name: live.imagePath).sink { result in
                            switch result {
                            case .finished:
                                
                                repository.deleteLive(id: live.id)
                                dismiss()
                                
                                break
                            case .failure(let error):
                                dismiss()
                                rootEnvironment.presentErrorView(title: ImageError.title, messege: error.message)
                                return
                            }
                        } receiveValue: { _ in
                            
                        }.store(in: &cancellables)
                    }
                    
                    
                } label: {
                    Text(L10n.deleteButtonTitle)
                }
            }.alert(L10n.deleteTimetableAlertTitle(deleteTimeTable?.artist ?? ""), isPresented: $isDeleteTimeTableDialog) {
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

// MARK: - Receive
struct SideBarTitleView: View {
    public let title: String
    
    public var trailingAction: () -> Void = {}
    public var imgName: String = ""
    
    var body: some View {
        HStack {
            
            if imgName != "" {
                Spacer()
                    .padding(.leading, 20)
                    .frame(width: 30)
            }
            
            Spacer()
            
            Rectangle()
                .frame(width: 70, height: 1)
                .foregroundStyle(.themaYellow)
            
            
            Text(title)
                .foregroundStyle(.themaYellow)
                .font(.system(size: 12))
                .padding(.horizontal, 20)
            
            
            Rectangle()
                .frame(width: 70, height: 1)
                .foregroundStyle(.themaYellow)
            
            Spacer()
            
            if imgName != "" {
                Button {
                    trailingAction()
                } label: {
                    Image(systemName: imgName)
                        .padding(.trailing, 20)
                        .frame(width: 30)
                        .foregroundStyle(.themaYellow)
                }
            }
        }.padding(.vertical)
    }
}

// MARK: - Receive
struct SwitchInputEditorView: View {
    
    public var live: Live
    
    @State var isEdit: Bool = false
    @State var text: String = ""
    
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    @FocusState var isActive:Bool
    
    var body: some View {
        VStack {
            
            SideBarTitleView(title: L10n.liveSetlist, trailingAction: {
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
            }, imgName: isEdit ? "checkmark.square" : "square.and.pencil")
            
            
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
                        .textSelection(.enabled)
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


struct LiveItemView: View {
    // MARK: - Receive
    public var label: String
    public var value: String
    
    var body: some View {
        VStack {
            Text(label)
                .foregroundStyle(.themaYellow)
                .font(.system(size: 12))
            Text(value)
                .foregroundStyle(.white)
                .font(.system(size: 20))
                .textSelection(.enabled)
        }
    }
}

#Preview {
    DetailLiveView(live: Live.demoLive)
}
