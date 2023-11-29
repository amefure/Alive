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
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 1) {
                ForEach(lives) { live in
                    NavigationLink {
                        DetailLiveView(live: live)
                    } label: {
                        HStack {
                            
                            Text(dateFormatManager.getStringBlake(date: live.date))
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
                                .lineLimit(1)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.forward")
                                .padding(10)
                                .foregroundStyle(.opacityGray)
                        }
                        
                    }.padding(.vertical, 10)
                        .background(Color.white)
                        .foregroundStyle(.foundation)
                        .fontWeight(.bold)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.horizontal, 20)
                }
            }
        }.scrollContentBackground(.hidden)
            .background(.foundation)
    }
}




#Preview {
    LiveScheduleListView(lives: Live.demoLives)
}
