//
//  RootView.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/12/08.
//

import SwiftUI

struct RootView: View {
    
    @ObservedObject private var rootEnvironment = RootEnvironment(sessionManager: SessionManager(), repositoryViewModel: RepositoryViewModel.shared)
    
    var body: some View {
        ZStack {
            ContentView()
                .environmentObject(rootEnvironment)
            
            if rootEnvironment.isPresentErrorDialog {
                CustomDialog()
                    .environmentObject(rootEnvironment)
            }
        }.background(Color.foundation)
    }
}

#Preview {
    RootView()
}
