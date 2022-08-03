//
//  OnboardingViewModel.swift
//  ToGather
//
//  Created by yudonlee on 2022/06/16.
//

import SwiftUI

/// 앱의 처음 여부 실행만 관련된 뷰모델.
class OnBoardingViewModel: ObservableObject {
    @Published var isFirstOn = false
    init() {
        self.checkIsFirstOn()
    }
    /// 객체 생성시, 앱이 처음으로 구동됐는지 판단시켜준다.
    private func checkIsFirstOn() {
        if !UserDefaults.standard.bool(forKey: "isNotFirstOn") {
            UserDefaults.standard.set(true, forKey: "isNotFirstOn")
            self.isFirstOn = true
        } else {
            self.isFirstOn = false
        }
    }
    /// 앱이 처음 구동되어 온보딩페이지에서 작동되다가,
    func setNotFirstOn() {
        self.isFirstOn = false
    }
    func setFirstOn() {
        self.isFirstOn = true
    }
}
