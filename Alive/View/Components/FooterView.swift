//
//  FooterView.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import SwiftUI

struct FooterView: View {
    
    @State var isShowInput: Bool = false
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "app")
            }

            
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "square.grid.2x2")
            }
            
            Spacer()
            Button {
                isShowInput = true
            } label: {
                Asset.Images.ticketIcon.swiftUIImage
                    .resizable()
                    .frame(width: 25, height: 25)
            }

      
            Spacer()
            Button {
            } label: {
                Image(systemName: "gearshape")
            }
            
            Spacer()
        }.clipped()
        .padding()
        .background(.ultraThinMaterial)
        .frame(width: UIScreen.main.bounds.width)
            .shadow(color: .gray,radius: 3, x: 1, y: 1)
            .offset(y:UIScreen.main.bounds.height / 2.3)
            .sheet(isPresented: $isShowInput, content: {
                InputLiveView(live: nil)
            })
    }
}

#Preview {
    FooterView()
}
