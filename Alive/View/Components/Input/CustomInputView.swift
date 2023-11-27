//
//  CustomInputView.swift
//  Alive
//
//  Created by t&a on 2023/11/27.
//

import SwiftUI

// MARK: - 汎用的な入力ボックス
struct CustomInputView: View {
    
    // MARK: - Receive
    @Binding var text: String
    public var imgName: String
    public var placeholder: String
    
    var body: some View {
        HStack {
            Image(systemName: imgName)
                .foregroundStyle(.black)
                .frame(width: 23)
            TextField(placeholder, text: $text)
        }.padding()
            .background(.regularMaterial)
            .environment(\.colorScheme, .light)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding()
    }
}

#Preview {
    CustomInputView(text: Binding.constant("text"), imgName: "imgName", placeholder: "placeholder")
}
