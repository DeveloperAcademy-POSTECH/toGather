//
//  MainView.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/09.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                friendsSavingsView
                    .padding()
                Divider()
                    .padding(.horizontal)
                    .padding(.bottom, 25)
                mySavingsView
                Spacer(minLength: 68)
                bottomView
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Text("친구 저축현황")
                        .font(.system(size: 22, weight: .bold))
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        //
                    } label: {
                        Image(systemName: "bell.badge.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle( .red, Color.basicBlack.opacity(0.4))
                    }
                    .foregroundColor(.basicBlack.opacity(0.4))
                    Button {
                        //
                    } label: {
                        Image(systemName: "gear")
                    }
                    .foregroundColor(.basicBlack.opacity(0.4))
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension MainView {
    var friendsSavingsView: some View {
                HStack(spacing: 26) {
                    FriendsProgressCircle(color: RGBColorInProgressCircle.friendColor1,
                                          progressPercent: DummyData.sampleSavings[1].progressPercent,
                                          friendName: "Tim", friendProduct: DummyData.sampleSavings[1].goalProduct)
                    FriendsProgressCircle(color: RGBColorInProgressCircle.friendColor2,
                                          progressPercent: DummyData.sampleSavings[2].progressPercent,
                                          friendName: "Steve", friendProduct: DummyData.sampleSavings[2].goalProduct)
                    FriendsProgressCircle(color: RGBColorInProgressCircle.friendColor3,
                                          progressPercent: DummyData.sampleSavings[3].progressPercent,
                                          friendName: "Cook", friendProduct: DummyData.sampleSavings[3].goalProduct)
                }
    }
    var mySavingsView: some View {
        VStack {
            HStack {
                Text("나의 저축현황")
                    .font(.system(size: 22, weight: .bold))
                Spacer()
            }
            .padding(.horizontal)
            MyProgressCircle()
                .padding(.horizontal)
        }
    }
    var bottomView: some View {
        VStack {
            HStack {
                Text("13회")
                    .font(.callout)
                    .foregroundColor(.pointColor)
                    .bold()
                Text("저축까지 남은 시간")
                    .font(.system(size: 14))
                    .foregroundColor(.basicBlack.opacity(0.6))
            }
            Button {
                //
            } label: {
                Label {
                    Text("6일 20시간 40분")
                        .font(.callout)
                        .foregroundColor(.white)
                } icon: {
                    Image(systemName: "clock")
                        .foregroundColor(.white)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 46)
            .background(Color.basicBlack.opacity(0.3))
            .cornerRadius(30)
            .padding(.horizontal)
        }
    }
}
