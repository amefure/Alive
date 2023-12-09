//
//  DetailLiveView.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/12/09.
//

import SwiftUI

struct DetailLiveView: View {
    
    private let dateFormatManager = DateFormatManager()
    
    // MARK: - Receive
    var live: Live
    
    var body: some View {
        ScrollView {
            
            ItemView(label: L10n.liveType, value: live.type.value)
            
            ItemView(label: L10n.liveName, value: live.name)
            
            ItemView(label: L10n.liveArtist, value: live.artist)
            
            ItemView(label: L10n.liveVenue, value: live.venue)
            
            ItemView(label: L10n.livePrice, value: live.price == -1 ? L10n.livePriceNone : L10n.livePriceUnit(live.price))
            
            ItemView(label: L10n.liveDate, value: dateFormatManager.getString(date: live.date))
            
            ItemView(label: L10n.liveOpeningTime, value: live.openingTime != nil ? dateFormatManager.getTimeString(date: live.openingTime!) : "0:00")
            
            ItemView(label: L10n.livePerformanceTime, value: live.performanceTime != nil ? dateFormatManager.getTimeString(date: live.performanceTime!) : "0:00")
            
            ItemView(label: L10n.liveClosingTime, value: live.closingTime != nil ? dateFormatManager.getTimeString(date: live.closingTime!) : "0:00")
            
            ItemView(label: L10n.liveMemo, value: live.memo)
            
            if live.type == .festival {
                VStack(spacing: 0) {
                    Text(L10n.liveTimeTable)
                        .foregroundStyle(.themaYellow)
                        .font(.system(size: 9))
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    
                    ForEach(live.timeTable.sorted(by: {$0.time < $1.time})) { row in
                        HStack {
                            Text(dateFormatManager.getTimeString(date: row.time))
                                .font(.system(size: 9))
                            Text(row.artist)
                            Spacer()
                        }.padding()
                        .background(row.color.color)
                    }
                    
                }.padding(5)
            } else {
                ItemView(label: L10n.liveSetlist, value: live.setList)
            }

        }.frame(width: DeviceSizeManager.deviceWidth)
            .background(Color.foundation)
            
        
    }
}

struct ItemView: View {
    
    public var label: String
    public var value: String
    
    var body: some View {
        VStack {
            Text(label)
                .foregroundStyle(.themaYellow)
                .font(.system(size: 9))
                .fontWeight(.bold)
            
            Text(value)
                .fontWeight(.bold)
            
        }.padding(5)
        
    }
}

#Preview {
    DetailLiveView(live: Live.demoLive)
}
