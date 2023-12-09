//
//  DeviceSizeManager.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/12/08.
//

import WatchKit

class DeviceSizeManager {

    static var deviceWidth: CGFloat {
        return WKInterfaceDevice.current().screenBounds.size.width
    }

    static var deviceHeight: CGFloat {
        return WKInterfaceDevice.current().screenBounds.size.height
    }
    
}
