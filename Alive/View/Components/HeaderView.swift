//
//  HeaderView.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import SwiftUI

struct HeaderView: View {
    
    // MARK: - Receive
    public var leadingIcon: String = ""
    public var trailingIcon: String  = ""
    public var leadingAction: () -> Void = {}
    public var trailingAction: () -> Void = {}
    public var isShowLogo: Bool = true
    
    var body: some View {
        HStack {
            
            if !leadingIcon.isEmpty {
                
                Button {
                    leadingAction()
                } label: {
                    Image(systemName: leadingIcon)
                }.padding(.leading, 5)
                    .frame(width: 50)
            } else if !trailingIcon.isEmpty {
                Spacer()
                    .frame(width: 50)
            }
            
            Spacer()
            
            if isShowLogo {
                Asset.Images.appLogoElectric.swiftUIImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                
            }
            
            Spacer()
            
            if !trailingIcon.isEmpty {
                Button {
                    trailingAction()
                } label: {
                    Image(systemName: trailingIcon)
                }.padding(.trailing, 5)
                    .frame(width: 50)
            } else if !leadingIcon.isEmpty {
                Spacer()
                    .frame(width: 50)
            }
        }
    }
}

#Preview {
    HeaderView(leadingIcon: "", trailingIcon: "", leadingAction: {}, trailingAction: {})
}
