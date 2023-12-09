//
//  CardLiveView.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/12/08.
//

import SwiftUI

struct CardLiveView: View {
    
    // MARK: - Utility
    private let dateFormatManager = DateFormatManager()
    
    // MARK: - Receive
    public var live: Live
    
    var body: some View {
        VStack(spacing:0) {
            
            HStack {
                
                Asset.Images.appLogoElectric.swiftUIImage
                    .resizable()
                    .frame(width: 20, height: 20)
                    .background(.foundation)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white, lineWidth: 2)
                        
                    ).padding(.leading, 5)
                
                Text(live.name)
                    .frame(height: 50)
                    .font(.system(size: 12))
                    .padding(.leading, 5)
                    .lineLimit(2)
                
                
                Spacer()
                
            }.foregroundStyle(.white)
            
            ZigzagBottomLine()
                .fill(Color.white)
                .frame(width: DeviceSizeManager.deviceWidth - 10, height: 1)
            
            VStack {
                HStack {
                    VStack {
                        HStack {
                            Image(systemName: "music.mic")
                                .font(.system(size: 12))
                                .padding(.leading, 5)
                            
                            Text(live.type == .festival ? live.artist + " etc.." : live.artist)
                                .font(.system(size: 12))
                                .lineLimit(1)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 12))
                                .padding(.leading, 5)
                            
                            Text(live.venue)
                                .font(.system(size: 12))
                                .lineLimit(1)
                            
                            Spacer()
                        }
                    }
                    
                    MonthAndDayView(month: dateFormatManager.getMouthAndDayString(date: live.date).0, day: dateFormatManager.getMouthAndDayString(date: live.date).1, size: 40)
                        .padding(.trailing, 5)
                    
                }
            }.frame(height: DeviceSizeManager.deviceHeight / 4)
                .background(Color.white)
                .foregroundStyle(.foundation)
            
            
        }.background(live.type.color)
            .frame(width: DeviceSizeManager.deviceWidth - 5)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .fontWeight(.bold)
            .padding(6)
            .shadow(color: .black ,radius: 2, x: 4, y: 4)
    }
}

// MARK: - ギザギザ横線
struct ZigzagBottomLine: Shape {
    var zigzagSpacing: CGFloat = 25.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.height))
        
        for x in stride(from: 0, to: rect.width, by: zigzagSpacing) {
            path.addLine(to: CGPoint(x: x + zigzagSpacing / 2, y: rect.height - zigzagSpacing * 0.3))
            path.addLine(to: CGPoint(x: x + zigzagSpacing, y: rect.height))
        }
        
        return path
    }
}

#Preview {
    CardLiveView(live: Live.blankLive)
}

