//
//  MonthAndDayView.swift
//  Alive
//
//  Created by t&a on 2023/11/24.
//

import SwiftUI

struct MonthAndDayView: View {
    
    public var month: String
    public var day: String
    public var size: CGFloat
    
    public var offsetMonth: CGFloat {
        (size / 4) * -1
    }
    
    public var offsetDay: CGFloat {
        size / 4
    }
    
    public var fontSize: Font {
        if size <= 40 {
            return .subheadline
        } else {
            return .largeTitle
        }
    }
    
    var body: some View {
        ZStack() {
            Text(month)
                .font(fontSize)
                .offset(x: offsetMonth, y: offsetMonth)
            
            Rectangle()
                .frame(width: size, height: 3)
                .rotationEffect(Angle(degrees: -45.0))
            
            Text(day)
                .font(fontSize)
                .offset(x: offsetDay, y: offsetDay)
        }.fontWeight(.bold)
    }
}

#Preview {
    MonthAndDayView(month: "11", day: "22", size: 80)
}
