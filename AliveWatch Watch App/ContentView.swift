//
//  ContentView.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/11/30.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = iOSConnectViewModel.shared
    var body: some View {
        VStack {
            Button {
                viewModel.requestLivesData()
            } label: {
                Text("ddd")
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
