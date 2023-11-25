//
//  ArtistGridListView.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import SwiftUI

struct ArtistGridListView: View {
    
    
    // MARK: - ViewModel
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // MARK: - View

    
    // MARK: - Glid Layout
    
    private var gridItemWidth: CGFloat {
        return CGFloat(DeviceSizeManager.deviceWidth / 3) - 20
    }
    
    private var gridColumns: [GridItem] {
        Array(repeating: GridItem(.fixed(gridItemWidth)), count: 3)
    }
    
    var body: some View {
    
            VStack {
                
                Text("LIVE COUNT")
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
             
                ScrollView {
                    LazyVGrid(columns: gridColumns) {
                        
                        ForEach(repository.getArtistCounts, id: \.key) { artist, count in
                            
                            VStack {
                                Text(artist)
                                    .font(.caption)
                                    .lineLimit(1)
                                
                                Text("\(count)")
                                    .font(.title)
                                    .foregroundStyle(.themaYellow)
                                
                            }.padding(5)
                                .frame(width: gridItemWidth , height: gridItemWidth)
                                .background(.black)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.black, lineWidth: 2)
                                )
                                .shadow(color: .gray ,radius: 2, x: 1, y: 1)
                                .padding(.horizontal, 8)
                        }
                        
                    }
                }.scrollContentBackground(.hidden)
                    .background(.foundation)
            
            
        }.background(.foundation)
            .onAppear {
                repository.readAllLive()
            }
        
    }
}

#Preview {
    ArtistGridListView()
}
