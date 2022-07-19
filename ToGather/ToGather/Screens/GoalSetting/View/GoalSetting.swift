//
//  GoalSetting.swift
//  ToGather
//
//  Created by yeongwoocho on 2022/06/09.
//

import SwiftUI

struct GoalSetting: View {
    
    // MARK: - Properties
    @State var isSelectedItem: String?
    @StateObject var onboardingViewModel: OnBoardingViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var isPresentationMode: Bool = false
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                GoalSettingTitleView()
                VStack(spacing: 0) {
                    HStack(alignment: .bottom, spacing: 4) {
                        Text(ItemData.firstHeadline.title())
                            .font(.system(size: 20))
                            .fontWeight(.heavy)
                            .foregroundColor(Color.pointColor)
                            .padding(.leading, 20)
                        Text("미만")
                            .foregroundColor(Color.basicBlack)
                            .padding(.bottom, 2) // for same border line
                        Spacer()
                    } // HStack
                    .padding(.bottom, 6)
                    Divider()
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                    HStack(alignment: .center, spacing: 0) {
                        GoalItem(imageTitle: ItemData.firstItem.title(),
                                 price: ItemData.firstItem.price(),
                                 isSelectedItem: $isSelectedItem)
                        Spacer()
                        GoalItem(imageTitle: ItemData.secondItem.title(),
                                 price: ItemData.secondItem.price(),
                                 isSelectedItem: $isSelectedItem)
                        Spacer()
                        GoalItem(imageTitle: ItemData.thirdItem.title(),
                                 price: ItemData.thirdItem.price(),
                                 isSelectedItem: $isSelectedItem)
                    } // HStack
                    .padding(.horizontal, 20)
                } // VStack
                .padding(.vertical, 22)
                VStack(spacing: 0) {
                    HStack(alignment: .bottom, spacing: 4) {
                        Text(ItemData.secondHeadline.title())
                            .font(.system(size: 20))
                            .fontWeight(.heavy)
                            .foregroundColor(Color.pointColor)
                            .padding(.leading, 20)
                        Text("미만")
                            .foregroundColor(Color.basicBlack)
                            .padding(.bottom, 2) // for same border line
                        Spacer()
                    } // HStack
                    .padding(.bottom, 6)
                    Divider()
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                    HStack(alignment: .center, spacing: 0) {
                        GoalItem(imageTitle: ItemData.fourthItem.title(),
                                 price: ItemData.fourthItem.price(),
                                 isSelectedItem: $isSelectedItem)
                        Spacer()
                        GoalItem(imageTitle: ItemData.fifthItem.title(),
                                 price: ItemData.fifthItem.price(),
                                 isSelectedItem: $isSelectedItem)
                        Spacer()
                        GoalItem(imageTitle: ItemData.sixthItem.title(),
                                 price: ItemData.sixthItem.price(),
                                 isSelectedItem: $isSelectedItem)
                    } // HStack
                    .padding(.horizontal, 20)
                } // VStack
                .padding(.vertical, 22)
                VStack(spacing: 0) {
                    HStack(alignment: .bottom, spacing: 4) {
                        Text(ItemData.thirdHeadline.title())
                            .font(.system(size: 20))
                            .fontWeight(.heavy)
                            .foregroundColor(Color.pointColor)
                            .padding(.leading, 20)
                        Text("미만")
                            .foregroundColor(Color.basicBlack)
                            .padding(.bottom, 2) // for same border line
                        Spacer()
                    } // HStack
                    .padding(.bottom, 6)
                    Divider()
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                    HStack(alignment: .center, spacing: 0) {
                        GoalItem(imageTitle: ItemData.seventhItem.title(),
                                 price: ItemData.seventhItem.price(),
                                 isSelectedItem: $isSelectedItem)
                        Spacer()
                        GoalItem(imageTitle: ItemData.eighthItem.title(),
                                 price: ItemData.eighthItem.price(),
                                 isSelectedItem: $isSelectedItem)
                        Spacer()
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 100, height: 100, alignment: .center)
                    } // HStack
                    .padding(.horizontal, 20)
                } // VStack
                .onTapGesture {
                    isSelectedItem = nil
                }
                .padding(.vertical, 22)
                Spacer()
                NavigationLink(destination: SettingPeriodView(onboardingViewModel: onboardingViewModel, isPresentationMode: $isPresentationMode).onAppear {
                    guard let Item = isSelectedItem, let product = Product.productDictionary[Item]?.productName else {
                        return
                    }
                    userViewModel.addProduct(product: product)
                },isActive: $isPresentationMode, label: {
                    Text("다음")
                        .fontWeight(.bold)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 46)
                        .foregroundColor(.white)
                        .background(isSelectedItem != nil ? Color.pointColor : Color.basicBlack.opacity(0.3))
                        .cornerRadius(30)
                        .padding(.horizontal, 20)
                        
                })
            } // VStack
            .navigationBarHidden(true)
        } // NavigationView
    }
}

// commit 살릴부분
struct GoalSetting_Previews: PreviewProvider {
    static var previews: some View {
        GoalSetting(onboardingViewModel: OnBoardingViewModel()).environmentObject(UserViewModel())
    }
}
