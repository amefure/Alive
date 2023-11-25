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

    // インタースティシャル
    public func incrementCount() {
        isCount += 1
        userDefaultsRepository.setIntData(key: UserDefaultsKey.COUNT_INTERSTITIAL_KEY, value: isCount)
    }
    
    public func resetCount() {
        isCount = 0
        userDefaultsRepository.setIntData(key: UserDefaultsKey.COUNT_INTERSTITIAL_KEY, value: isCount)
    }
    
    // 容量追加
    public func addCapacity() {
        let current = getCapacity()
        let capacity = current + AdsConfig.ADD_CAPACITY
        userDefaultsRepository.setIntData(key: UserDefaultsKey.LIMIT_CAPACITY, value: capacity)
    }
    
    // 容量取得
    public func getCapacity() -> Int {
        let capacity = userDefaultsRepository.getIntData(key: UserDefaultsKey.LIMIT_CAPACITY)
        if capacity == 0 {
            return AdsConfig.INITIAL_CAPACITY
        } else {
            return capacity
        }
    }
    
    // 最終視聴日
    public func registerAcquisitionDate(date: String) {
        userDefaultsRepository.setStringData(key: UserDefaultsKey.LAST_ACQUISITION_DATE, value: date)
    }
    
    // 最終視聴日
    public func getAcquisitionDate() -> String {
        userDefaultsRepository.getStringData(key: UserDefaultsKey.LAST_ACQUISITION_DATE)
    }
}
