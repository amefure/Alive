//
//  FooterView.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import SwiftUI

struct FooterView: View {
    
    @Binding var selectedTab: Int
    @State var isShowInput: Bool = false
    
    var body: some View {
        
            HStack {
                Spacer()
                Button {
                    selectedTab = 1
                } label: {
                    Image(systemName: "list.bullet.below.rectangle")
                    
                }.frame(width: 60, height: 60)
                    .background(.themaYellow)
                    .foregroundStyle(.foundation)
                    .clipShape(RoundedRectangle(cornerRadius: 60))

                
                Spacer()

                Button {
                    isShowInput = true
                } label: {
                    Image(systemName: "plus")
                }.padding()
                    .frame(width: 60, height: 60)
                    .background(.themaYellow)
                    .foregroundStyle(.foundation)
                    .clipShape(RoundedRectangle(cornerRadius: 60))
                   
                Spacer()
                
                
                Button {
                    selectedTab = 2
                } label: {
                    Image(systemName: "chart.bar")
                }.frame(width: 60, height: 60)
                    .background(.themaYellow)
                    .foregroundStyle(.foundation)
                    .clipShape(RoundedRectangle(cornerRadius: 60))

                
                Spacer()
            }.padding()
            .fontWeight(.bold)
            .background(.foundation)
            .frame(width: DeviceSizeManager.deviceWidth)
                .shadow(color: .gray,radius: 3, x: 1, y: 1)
                .offset(y: DeviceSizeManager.deviceHeight / 2.3)
                .sheet(isPresented: $isShowInput, content: {
                    InputLiveView(live: nil)
                }).padding(5)
            
       
    }
}

#Preview {
    FooterView(selectedTab: Binding.constant(0))
}
