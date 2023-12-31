//
//  FooterView.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import SwiftUI

struct FooterView: View {
    
    // MARK: - ViewModel
    private let userDefaults = UserDefaultsRepositoryViewModel.sheard
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // MARK: - Environment
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    
    // MARK: - Binding
    @Binding var selectedTab: Int
    
    // MARK: - View
    @State private var isShowInput: Bool = false
    @State private var isShowCapacityAlert: Bool = false
    
    private var btnSize: CGFloat {
        if DeviceSizeManager.isSESize {
            return 45
        } else {
            return 60
        }
    }
    
    var body: some View {
        
        HStack {
            Spacer()
            Button {
                selectedTab = 1
            } label: {
                Image(systemName: "list.bullet.below.rectangle")
                
            }.frame(width: btnSize, height: btnSize)
                .background(.themaYellow)
                .foregroundStyle(.foundation)
                .clipShape(RoundedRectangle(cornerRadius: btnSize))
            
            
            Spacer()
            
            Button {
                if userDefaults.getCapacity() > repository.lives.count {
                    isShowInput = true
                } else {
                    isShowCapacityAlert = true
                }
                
            } label: {
                Image(systemName: "plus")
            }.padding()
                .frame(width: btnSize, height: btnSize)
                .background(.themaYellow)
                .foregroundStyle(.foundation)
                .clipShape(RoundedRectangle(cornerRadius: btnSize))
            
            Spacer()
            
            
            Button {
                selectedTab = 2
            } label: {
                Image(systemName: "chart.bar")
            }.frame(width: btnSize, height: btnSize)
                .background(.themaYellow)
                .foregroundStyle(.foundation)
                .clipShape(RoundedRectangle(cornerRadius: btnSize))
            
            
            Spacer()
        }.padding()
            .fontWeight(.bold)
            .background(.foundation)
            .frame(width: DeviceSizeManager.deviceWidth)
            .shadow(color: .gray,radius: 3, x: 1, y: 1)
            .offset(y: DeviceSizeManager.deviceHeight / 2.3)
            .sheet(isPresented: $isShowInput, content: {
                InputLiveView(live: nil)
                    .environmentObject(rootEnvironment)
            }).padding(5)
            .alert(Text(L10n.adsLimitAlertTitle),
                   isPresented: $isShowCapacityAlert,
                   actions: {
                Button(action: {}, label: {
                    Text("OK")
                })
            }, message: {
                Text((L10n.adsLimitAlertMsg))
            })
        
    }
}

#Preview {
    FooterView(selectedTab: Binding.constant(0))
}
