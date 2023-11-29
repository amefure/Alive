//
//  CardLiveView.swift
//  Alive
//
//  Created by t&a on 2023/11/24.
//

import SwiftUI

struct CardLiveView:View {
    
    // MARK: - Utility
    private let imageFileManager = ImageFileManager()
    private let dateFormatManager = DateFormatManager()
    
    // MARK: - Receive
    public var live: Live?
    
    private var imgSize: CGFloat {
        if DeviceSizeManager.isSESize {
            return 40
        } else {
            return 50
        }
    }
    
    var body: some View {
        if let live = live {
            
            VStack(spacing:0) {
                
                HStack {
                    
                    if let image = imageFileManager.loadImage(name: live.imagePath) {
                        
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: imgSize, height: imgSize)
                            .background(.foundation)
                            .clipShape(RoundedRectangle(cornerRadius: imgSize))
                            .overlay(
                                RoundedRectangle(cornerRadius: imgSize)
                                    .stroke(.white, lineWidth: 3)
                                
                            ).padding(.leading, 20)
                        
                    } else {
                        Asset.Images.appLogoElectric.swiftUIImage
                            .resizable()
                            .frame(width: imgSize, height: imgSize)
                            .background(.foundation)
                            .clipShape(RoundedRectangle(cornerRadius: imgSize))
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(.white, lineWidth: 3)
                                
                            ).padding(.leading, 20)
                        
                    }
                    
                    
                    Text(live.name)
                        .frame(height: DeviceSizeManager.isSESize ? 80 : 100)
                        .font(.system(size: DeviceSizeManager.isSESize ? 14 : 20))
                        .padding(.leading, 20)
                        .textSelection(.enabled)
                    
                    
                    Spacer()
                    
                }.foregroundStyle(.white)
                
                ZigzagBottomLine()
                    .fill(Color.white)
                    .frame(width: DeviceSizeManager.deviceWidth - 55, height: 1)
                VStack {
                    HStack {
                        
                        VStack {
                            HStack {
                                Image(systemName: "music.mic")
                                    .padding(.leading, 20)
                                
                                Text(live.type == .festival ? live.artist + " etc.." : live.artist)
                                    .textSelection(.enabled)
                                Spacer()
                            }
                            
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                    .padding(.leading, 20)
                                Text(live.venue)
                                    .textSelection(.enabled)
                                Spacer()
                            }
                        }
                        
                        MonthAndDayView(month: dateFormatManager.getMouthAndDayString(date: live.date).0, day: dateFormatManager.getMouthAndDayString(date: live.date).1, size: DeviceSizeManager.isSESize ? 65 : 80)
                            .padding(.trailing, 20)
                        
                    }
                }.frame(height: DeviceSizeManager.isSESize ? 80 : 100)
                    .background(Color.white)
                    .foregroundStyle(.foundation)
                
                
            }.background(live.type.color)
                .frame(width: DeviceSizeManager.deviceWidth - 45)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .fontWeight(.bold)
                .padding(6)
                .shadow(color: .black ,radius: 2, x: 4, y: 4)
        }
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
    CardLiveView()
}
