//
//  LiveImageView.swift
//  Alive
//
//  Created by t&a on 2023/11/21.
//

import SwiftUI

struct LiveImageView: View {
    
    // MARK: - Receive
    public var image: UIImage?
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                    .resizable()
                    .aspectRatio(CGSize(width: 3, height: 2), contentMode: .fill)
                    .frame(width: DeviceSizeManager.deviceWidth, height: 160)
                    .clipped()
        } else {
            Asset.Images.appLogoElectric.swiftUIImage
                .resizable()
                .frame(width: 200, height: 160)
        }
    }
}

#Preview {
    LiveImageView(image: nil)
}
