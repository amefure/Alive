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
    
    // MARK: - Environment
    @EnvironmentObject private var rootEnvironment: RootEnvironment
    
    // MARK: - Receive
    public let lives: [Live]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 1) {
                ForEach(lives) { live in
                    NavigationLink {
                        DetailLiveView(live: live)
                            .environmentObject(rootEnvironment)
                    } label: {
                        HStack {
                            
                            Text(dateFormatManager.getStringBlake(date: live.date))
                                .font(.caption)
                                .frame(width: 60)
                                .padding(.leading, 10)
                            
                            ZStack {
                                Text("")
                                    .padding(10)
                                    .frame(width: 80)
                                    .background(live.type.color)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .opacity(0.8)
                                
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
                                .foregroundStyle(.white)
                        }
                        
                    }.padding(.vertical, 10)
                        .background(Color.black)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.horizontal, 10)
                }
            }
        }.scrollContentBackground(.hidden)
            .background(.foundation)
    }
}




#Preview {
    LiveScheduleListView(lives: Live.demoLives)
}
