//
//  ShareLiveInfoView.swift
//  Alive
//
//  Created by t&a on 2023/11/28.
//

import SwiftUI

struct ShareLiveInfoView: View {
    
    // MARK: - ViewModel
    @ObservedObject private var viewModel = ShareLiveInfoViewModel.shared
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    @State private var isNoTextAlert: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            HeaderView(leadingIcon: "chevron.backward", leadingAction: { dismiss() })
            
            HStack {
                
                Spacer()
                    .frame(width: 100)
                    .padding(.leading, 10)
                
                Spacer()
                
                // MARK: - SHARE TEXT
                Text("SHARE TEXT")
                    .fontWeight(.bold)
                    .padding(.vertical, DeviceSizeManager.isSESize ? 5 : 10)
                
                Spacer()
                
                Button {
                    viewModel.toggleFlag()
                } label: {
                    Text(viewModel.switchFlag ? L10n.liveArtist : L10n.liveName)
                        .font(.caption)
                }.padding(8)
                    .frame(width: 90)
                    .background(viewModel.switchFlag ? .themaPurple : .themaYellow )
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: .black ,radius: 2, x: 2, y: 2)
                    .foregroundStyle(.white)
                    .padding(.trailing, 10)
            }
            
            
            VStack {
                HStack {
                    
                    if viewModel.text.isEmpty {
                        Text(L10n.shareNoText)
                            .fontWeight(.bold)
                    } else {
                        Text(viewModel.text)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                }
                
                Spacer()
                
                Button {
                    if viewModel.text.isEmpty {
                        isNoTextAlert = true
                    } else {
                        viewModel.shareSnsLiveInfo()
                    }
                } label: {
                    Text("SHARE")
                }.padding(8)
                    .background(.themaYellow)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: .black ,radius: 2, x: 2, y: 2)
                    .foregroundStyle(.white)
                
                
            }.padding()
                .frame(width: DeviceSizeManager.deviceWidth - 40, height: 300)
                .background(.regularMaterial)
                .environment(\.colorScheme, .light)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding()
                .foregroundStyle(.foundation)
                .shadow(color: .black ,radius: 2, x: 4, y: 4)
            
            ScrollView {
                VStack(spacing: 1) {
                    ForEach(repository.lives) { live in
                        ShareRowLiveView(live: live)
                    }
                }
            }.padding(.horizontal, 20)
            
            Spacer()
            
            AdMobBannerView()
                .frame(height: DeviceSizeManager.isSESize ? 40 : 60)
            
        }.navigationBarBackButtonHidden()
            .navigationBarHidden(true)
            .background(.foundation)
            .foregroundStyle(.white)
            .alert(L10n.shareNoTextAlert, isPresented: $isNoTextAlert) {
                Button("OK") { }
            }
    }
}

struct ShareRowLiveView: View {
    
    // MARK: - Utility
    private let dateFormatManager = DateFormatManager()
    
    // MARK: - ViewModel
    @ObservedObject private var viewModel = ShareLiveInfoViewModel.shared
    
    // MARK: - Receive
    public let live: Live
    
    // MARK: - ViewM
    @State private var isCheck: Bool = false
    
    var body: some View {
        Button {
            if isCheck {
                viewModel.removeLive(live: live)
            } else {
                viewModel.addLive(live: live)
            }
            isCheck.toggle()
        } label: {
            if isCheck {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.themaYellow)
            } else {
                Image(systemName: "circle")
                    .foregroundStyle(.themaYellow)
            }
            
            HStack {
                
                Text(dateFormatManager.getStringBlake(date: live.date))
                    .font(.caption)
                    .frame(width: 55)

                Text(viewModel.switchFlag ? live.artist : live.name)
                    .lineLimit(1)
                
                Spacer()
            }
            
        }.padding(10)
            .background(Color.white)
            .foregroundStyle(.foundation)
            .fontWeight(.bold)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    ShareLiveInfoView()
}
