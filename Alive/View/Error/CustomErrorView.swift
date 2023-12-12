//
//  CustomErrorView.swift
//  Alive
//
//  Created by t&a on 2023/12/09.
//

import SwiftUI

struct CustomErrorView: View {
    
    @Binding var isPresented: Bool
    
    public let title: String
    public let message: String
    
    var body: some View {
        if isPresented {
            VStack {
                HeaderView()
                
                Text("ERROR")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.top, 40)
                
                Spacer()
                
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .foregroundStyle(.themaRed)
                    .padding(.bottom, 20)
                
                
                Text(title)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.bottom, 10)
                
                Text(message)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: DeviceSizeManager.deviceWidth - 40)
                
                
                Spacer()
                
                Button {
                    isPresented = false
                } label: {
                    Text(L10n.watchErrorBackButton)
                        .foregroundStyle(.white)
                }.padding()
                    .frame(width: DeviceSizeManager.deviceWidth - 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.white, lineWidth: 1)
                    ).padding(.bottom, 20)
                
            }.background(.foundation)
        }
    }
}

extension View {
    func dialog(isPresented: Binding<Bool>, title: String, message: String) -> some View
    {
        overlay(CustomErrorView(isPresented: isPresented, title: title, message: message))
    }
}

#Preview {
    CustomErrorView(isPresented: Binding.constant(true), title: "title", message: "message")
}
