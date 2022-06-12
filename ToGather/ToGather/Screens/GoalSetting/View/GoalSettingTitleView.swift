//
//  GoalSettingTitleView.swift
//  ToGather
//
//  Created by yeongwoocho on 2022/06/12.
//

import SwiftUI

struct GoalSettingTitleView: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("저축목표")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundColor(Color.pointColor)
            Text("를 골라주세요")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundColor(Color.basicBlack)
        } // HStack
        .padding(.top, 36)
        .padding(.leading, 20)
    }
}

struct GoalSettingTitleView_Previews: PreviewProvider {
    static var previews: some View {
        GoalSettingTitleView()
    }
}
