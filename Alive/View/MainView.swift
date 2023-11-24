//
//  MainView.swift
//  Alive
//
//  Created by t&a on 2023/11/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedTab = 1
    @State private var isShowSetting = false
    
    var body: some View {
        
        ZStack {
            VStack {
                HeaderView(trailingIcon: "gearshape",trailingAction: {
                    isShowSetting = true
                }).tint(.themaYellow)
                
                TabView(selection: $selectedTab ) {
                     
                    LiveScheduleListView()
                        .tag(1)
                
                    
                    ArtistGridListView()
                        .tag(2)
                }
            }
            
            FooterView(selectedTab: $selectedTab)
        }.background(.foundation)
            .navigationDestination(isPresented: $isShowSetting) {
                
            }
    }
}

#Preview {
    MainView()
}
