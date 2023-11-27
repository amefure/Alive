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
        ScrollView {
            ForEach(lives) { live in
                VStack(spacing: 0) {
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
                    }
                }.padding(.vertical, 10)
                    .background(Color.white)
                    .foregroundStyle(.foundation)
                    .fontWeight(.bold)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal, 10)
            }
        }.scrollContentBackground(.hidden)
            .background(.foundation)
            .padding(.bottom, 20)
    }
}




#Preview {
    LiveScheduleListView(lives: [])
}
