//
//  ContentView.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/11/30.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var repositoryViewModel = RepositoryViewModel.shared
    
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    
    var body: some View {
        NavigationStack {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if repositoryViewModel.lives.count != 0 {
                        ForEach(repositoryViewModel.lives) { live in
                            CardLiveView(live: live)
                        }
                    } else {
                        Button {
                            rootEnvironment.requestLivesData()
                        } label: {
                            CardLiveView(live: Live.blankLive)
                        }

                        
                    }
                }.padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    ContentView()
}
