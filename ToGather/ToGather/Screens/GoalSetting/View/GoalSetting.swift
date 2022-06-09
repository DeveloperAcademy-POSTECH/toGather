//
//  GoalSetting.swift
//  ToGather
//
//  Created by yeongwoocho on 2022/06/09.
//

import SwiftUI

struct GoalSetting: View {
    @State var isSelected: Bool
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                GoalItemRow(headline: "100만원",
                            firstImageTitle: "goal-airpod",
                            firstPrice: "300,000",
                            secondImageTitle: "goal-applewatch",
                            secondPrice: "500,000",
                            thirdImageTitle: "goal-ipad",
                            thirdPrice: "700,000")
                GoalItemRow(headline: "100만원",
                            firstImageTitle: "goal-airpod",
                            firstPrice: "300,000",
                            secondImageTitle: "goal-applewatch",
                            secondPrice: "500,000",
                            thirdImageTitle: "goal-ipad",
                            thirdPrice: "700,000")
                GoalItemRow(headline: "100만원",
                            firstImageTitle: "goal-airpod",
                            firstPrice: "300,000",
                            secondImageTitle: "goal-applewatch",
                            secondPrice: "500,000",
                            thirdImageTitle: "goal-ipad",
                            thirdPrice: "700,000")
                Button {
                    isSelected.toggle()
                } label: {
                    Text("다음")
                        .fontWeight(.bold)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 46)
                        .foregroundColor(.white)
                        .background(isSelected == true ? ColorStyle.blue.color : ColorStyle.blue.color.opacity(30))
                        .cornerRadius(30)
                }
            } // VStack
            .navigationTitle("저축목표를 골라주세요")
        } // NavigationView
    }
}

struct GoalSetting_Previews: PreviewProvider {
    static var previews: some View {
        GoalSetting(isSelected: false)
    }
}
