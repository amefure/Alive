//
//  CustomDialog.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/12/08.
//

import SwiftUI

struct CustomDialog: View {
    
    // MARK: - Environment
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    
    var body: some View {
        VStack {
            
            Text("ERROR")
                .fontWeight(.bold)
                .foregroundStyle(.themaRed)
            
            Spacer()
            
            Text(L10n.watchErrorText)
                .font(.system(size: 12))
                .foregroundStyle(.themaRed)
            
            Spacer()
            
            Button {
                rootEnvironment.isPresentErrorDialog = false
            } label: {
                Text(L10n.watchErrorBackButton)
            }

        }.padding()
            .background(Color.foundation)
    }
}

#Preview {
    CustomDialog()
}
