//
//  LiveListView.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import SwiftUI

struct LiveScheduleListView: View {
    
    // MARK: - Utility
    private let dateFormatManager = DateFormatManager()
    
    // MARK: - Receive
    public let lives: [Live]
    
    var body: some View {
        List {
            ForEach(lives) { live in
                NavigationLink {
                    DetailLiveView(live: live)
                } label: {
                    HStack {
                        
                        Text(dateFormatManager.getString2(date: live.date))
                            .font(.caption)
                            .frame(width: 60)
                        
                        ZStack {
                            Text("")
                                .padding(10)
                                .frame(width: 80)
                                .background(live.type.color)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .opacity(0.5)
                            
                            Text(live.type.value)
                                .padding(5)
                                .frame(width: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                        
                        
                        Text(live.artist)
                        
                        Spacer()
                    }
                }.padding(.vertical, 3)
                    .listRowSeparatorTint(Asset.Colors.foundation.swiftUIColor)
                    .listRowBackground(Color.white)
                    .foregroundStyle(.foundation)
                    .fontWeight(.bold)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }.scrollContentBackground(.hidden)
            .background(.foundation)
            .padding(.bottom, 20)
    }
}




#Preview {
    LiveScheduleListView(lives: [])
}
