//
//  RewardButtonView.swift
//  Alive
//
//  Created by t&a on 2023/11/25.
//

import SwiftUI

struct RewardButtonView: View {
    
    private let dateFormatManager = DateFormatManager()
    private let userDefaults = UserDefaultsRepositoryViewModel.sheard
    // MARK: - AdMob
    @ObservedObject var reward = Reward()

    // MARK: - View
    @State var isAlertReward: Bool = false // リワード広告視聴回数制限アラート
    
    var body: some View {
        Button(action: {
            // 1日1回までしか視聴できないようにする
            if userDefaults.getAcquisitionDate() != dateFormatManager.getNowTime() {
               
                //  広告配信
                reward.showReward()
                userDefaults.addCapacity()
                // 最終視聴日を格納
                userDefaults.registerAcquisitionDate(date: dateFormatManager.getNowTime())

            } else {
                isAlertReward = true
            }
        }) {
            HStack {
                Image(systemName: "bag.badge.plus")
                Text(reward.rewardLoaded ?  "広告を視聴して容量を追加する" : "広告を読み込み中です。" )
            }
        }
        .onAppear {
            reward.loadReward()
        }
        .disabled(!reward.rewardLoaded)
        .alert(Text("お知らせ"),
               isPresented: $isAlertReward,
               actions: {
                   Button(action: {}, label: {
                       Text("OK")
                   })
               }, message: {
                   Text("広告を視聴できるのは1日に1回までです。")
               })
    }
}

#Preview {
    RewardButtonView()
}
