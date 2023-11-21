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
            .tint(Asset.Colors.themaYellowColor.swiftUIColor)
            VStack {
                Text(live.artist)
                    .font(.largeTitle)
                
                Text(live.venue)
                    .font(.largeTitle)
                
                Text("\(live.price)円")
                    .font(.largeTitle)
                
                Text(live.type.value)
                    .font(.largeTitle)
               
                
                Text(dateFormatManager.getShortString(date: live.date))
                    .font(.largeTitle)
                
                Text(live.memo)
                    .font(.largeTitle)
                
                
                Button {
                   isDeleteDialog = true
               } label: {
                   Text(L10n.deleteButtonTitle)
                       .padding(.vertical, 7)
                       .frame(width: 100)
                       .foregroundStyle(Asset.Colors.themaYellowColor.swiftUIColor)
                       .overlay{
                           RoundedRectangle(cornerRadius: 8)
                               .stroke(style: StrokeStyle(lineWidth: 1))
                               .frame(width: 100)
                               .foregroundStyle(Asset.Colors.themaYellowColor.swiftUIColor)
                       }.padding(.top , 20)
               }
               
            }.padding(.bottom)
            
            Spacer()
        }.navigationBarBackButtonHidden()
            .navigationBarHidden(true)
            .fontWeight(.bold)
            .background(Asset.Colors.foundationColor.swiftUIColor)
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
