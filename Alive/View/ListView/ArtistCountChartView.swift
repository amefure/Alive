//
//  ArtistGridListView.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import SwiftUI

struct ArtistCountChartView: View {
    
    // MARK: - ViewModel
    @ObservedObject private var repository = RealmRepositoryViewModel.shared
    
    // MARK: - View
    @State var select: String = "bar"
    
    
    var body: some View {
        
        VStack {
            
            Text("LIVE COUNT")
                .fontWeight(.bold)
                .padding(.vertical, 10)
            
            Picker(selection: $select) {
                Image(systemName: "chart.bar").tag("bar")
                Image(systemName: "chart.pie.fill").tag("pie")
            } label: {
                Text("")
            }.pickerStyle(SegmentedPickerStyle())
            
            if select == "bar" {
                ArtistBarChartView(artistCounts: repository.getArtistCounts.reversed().suffix(5).reversed())
                    .frame(width: DeviceSizeManager.deviceWidth, height: DeviceSizeManager.isSESize ? 200 : 300)
                    .id(UUID()) // キャッシュをなくし再描画
            } else {
                ArtistPieChartView(artistCounts: repository.getArtistCounts.reversed().suffix(5))
                    .frame(width: DeviceSizeManager.deviceWidth, height: DeviceSizeManager.isSESize ? 200 : 300)
                    .id(UUID()) // キャッシュをなくし再描画
            }
            
            Rectangle()
                .frame(width: DeviceSizeManager.deviceWidth - 40 , height: 1)
                .background(.white)
            
            Spacer()
            
            List {
                ForEach(repository.getArtistCounts, id: \.key) { artist, count in
                    HStack {
                        Text(artist)
                        
                        Spacer()
                        
                        Text("\(count)")
                            .foregroundStyle(.themaYellow)
                        
                    }.padding(5)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
            }.scrollContentBackground(.hidden)
                .background(.clear)
            
            AdMobBannerView()
                .frame(height: DeviceSizeManager.isSESize ? 40 : 60)
                .padding(.bottom, DeviceSizeManager.isSESize ? 25 : 20)
            
        }.background(.foundation)
            .onAppear {
                repository.readAllLive()
            }
        
    }
}

#Preview {
    ArtistCountChartView()
}
