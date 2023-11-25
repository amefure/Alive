//
//  AllLiveListView.swift
//  Alive
//
//  Created by t&a on 2023/11/25.
//

import SwiftUI

struct AllLiveListView: View {
    
    
    public let lives: [Live]
    @State private var filteringLives: [Live] = []
    @State private var search: String = ""
    
    
    var body: some View {
        VStack {
            
            /// 検索ボックス
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Asset.Colors.themaGreen.swiftUIColor)
                TextField(L10n.liveArtist + "...", text: $search)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: search) { newValue in
                        if newValue.isEmpty {
                            filteringLives = lives
                        } else {
                            filteringLives = lives.filter( {$0.artist.contains(search) || $0.name.contains(search) })
                        }
                        
                    }
            }.padding(.horizontal, 20)
                .padding(.top, 10)
         
            LiveScheduleListView(lives: filteringLives)
            
        }.onAppear {
            filteringLives = lives
        }
.navigationBarBackButtonHidden()
                .navigationBarHidden(true)
                .background(.foundation)
    }
}

#Preview {
    AllLiveListView(lives: [])
}


extension Color {
    init(hexString: String, alpha: CGFloat = 1.0) {
        // 不要なスペースや改行があれば除去
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        // スキャナーオブジェクトの生成
        let scanner = Scanner(string: hexString)

        // 先頭(0番目)が#であれば無視させる
        if (hexString.hasPrefix("#")) {
            scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        }

        var color:Int64 = 0
        // 文字列内から16進数を探索し、Int64型で color変数に格納
        scanner.scanHexInt64(&color)

        let mask:Int = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red:red, green:green, blue:blue,opacity: alpha)
    }
    
    public func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        let uicolor = UIColor(cgColor: self.cgColor!)
        uicolor.getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return String(format:"#%06x", rgb)
    }

}

extension Color{
    static let thema:Color = Color(hexString: "#5D9B84")
    static let list:Color = Color(hexString: "#f2f2f7")
}
