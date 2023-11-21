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
            }, isShowLogo: true)
            .tint(.themaYellow)
            ScrollView {
                
                LiveImageView(image: imageFileManager.loadImage(name: live.imagePath))
                
                Text("「" + live.name + "」")
                        .font(.largeTitle)
                
                Rectangle()
                    .frame(width: DeviceSizeManager.deviceWidth, height: 2)
                    .background(.themaOrange)
            
                HStack {
                    Image(systemName: "music.mic")
                    Text(live.artist)
                        .font(.largeTitle)
                }
                
                
                Text("Live情報")
                VStack(alignment: .leading) {
                    
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .padding(.leading, 10)
                            .frame(width: 30)
                        Text(L10n.liveVenue + "：")
                        Text(live.venue)
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "banknote")
                            .padding(.leading, 10)
                            .frame(width: 30)
                        Text(L10n.livePrice + "：")
                        Text("\(live.price)円")
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "calendar")
                            .padding(.leading, 10)
                            .frame(width: 30)
                        Text(L10n.liveDate + "：")
                        Text(dateFormatManager.getString(date: live.date))
                        Spacer()
                    }
                    
                    HStack {
                        if let openingTime = live.openingTime {
                            HStack {
                                Text(L10n.liveOpeningTime + "：")
                                Text(dateFormatManager.getTimeString(date: openingTime))
                            }
                            
                            Spacer()
                        }
                        
                        
                        
                        if let performanceTime = live.performanceTime {
                            HStack {
                                Text(L10n.livePerformanceTime + "：")
                                Text(dateFormatManager.getTimeString(date: performanceTime))
                            }
                            
                            Spacer()
                        }
                        
                        if let closingTime = live.closingTime {
                            HStack {
                                Text(L10n.liveClosingTime + "：")
                                Text(dateFormatManager.getTimeString(date: closingTime))
                            }
                            
                            Spacer()
                        }
                    }.padding(.leading, 10)
                    
                }
                .frame(width: DeviceSizeManager.deviceWidth - 20)
                .padding(.vertical)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.white, lineWidth: 1)
                )
                
                
                
                if live.type != .unknown {
                 Text(live.type.value)
                     .padding()
                     .background(live.type.color)
                     .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                
                Text(live.memo)
                    .font(.largeTitle)
                
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
//            .fontWeight(.bold)
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



#Preview {
    DetailLiveView(live: Live.demoLive)
}
