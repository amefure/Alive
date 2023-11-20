//
//  UserDefaultsRepositoryViewModel.swift
//  Alive
//
//  Created by t&a on 2023/11/20.
//

import UIKit

class UserDefaultsRepositoryViewModel {
    
    static let sheard = UserDefaultsRepositoryViewModel()
    private let userDefaultsRepository = UserDefaultsRepository.sheard
    
    var isCount: Int = 0             // インタースティシャル用カウント
    
    var isInitialBoot: Bool = false  // 初回起動フラグ
    
    init() {
        isInitialBoot = userDefaultsRepository.getBoolData(key: UserDefaultsKey.APP_INITIAL_BOOT_FLAG)
        
        /// 初回起動時かどうか識別
        if !isInitialBoot {
            // 2回目起動以降にこの処理が走らないようにする
            userDefaultsRepository.setBoolData(key: UserDefaultsKey.APP_INITIAL_BOOT_FLAG, isOn: true)
        }
        
        /// インタースティシャルカウント
        isCount = userDefaultsRepository.getIntData(key: UserDefaultsKey.COUNT_INTERSTITIAL_KEY)
        
    }
    
    /// 取得
    public func getAppLockFlag() -> Bool {
        return userDefaultsRepository.getBoolData(key: UserDefaultsKey.APP_LOCK_KEY)
    }
    
    
    public func incrementCount() {
        isCount += 1
        userDefaultsRepository.setIntData(key: UserDefaultsKey.COUNT_INTERSTITIAL_KEY, value: isCount)
    }
    
    public func resetCount() {
        isCount = 0
        userDefaultsRepository.setIntData(key: UserDefaultsKey.COUNT_INTERSTITIAL_KEY, value: isCount)
    }
    
}
