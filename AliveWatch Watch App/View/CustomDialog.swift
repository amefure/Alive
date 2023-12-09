//
//  CustomDialog.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/12/08.
//

import SwiftUI

struct CustomDialog: View {
    @ObservedObject private var rootEnvironment = RootEnvironment(sessionManager: SessionManager())
    var body: some View {
        VStack {
            
            Spacer()
            Text("通信に失敗しました。")
                .foregroundStyle(.white)
            
            Spacer()
            
            Button {
                rootEnvironment.isPresentErrorDialog = false
            } label: {
                Text("TOPに戻る")
            }

        }.padding()
            .background(Color.black)
        
           
    }
}

#Preview {
    CustomDialog()
}
