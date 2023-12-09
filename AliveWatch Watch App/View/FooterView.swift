//
//  FooterView.swift
//  AliveWatch Watch App
//
//  Created by t&a on 2023/12/09.
//

import SwiftUI

struct FooterView: View {
    
    // MARK: - View
    @Binding var selectPage: Int
    
    var body: some View {
        HStack(spacing: 10){
            
            Button {
                selectPage = 0
            } label: {
                Image(systemName: "person.text.rectangle")
                    .padding(5)
                    .background(Color.foundation)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(selectPage == 0 ? .themaYellow : .white)
            }.buttonStyle(.borderless)
        
            Button {
                selectPage = 1
            } label: {
                Image(systemName: "list.bullet")
                    .padding(5)
                    .background(Color.foundation)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(selectPage == 1 ? .themaYellow : .white)
            }.buttonStyle(.borderless)
        }
    }
}

#Preview {
    FooterView(selectPage: Binding.constant(0))
}
