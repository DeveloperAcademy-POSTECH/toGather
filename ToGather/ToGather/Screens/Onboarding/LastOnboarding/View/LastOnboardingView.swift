//
//  LastOnboardingView.swift
//  ToGather
//
//  Created by Seungwon Choi on 2022/06/09.
//

import SwiftUI
import Firebase

struct LastOnboardingView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @ObservedObject var lastOnboardingViewModel: LastOnboardingViewModel = LastOnboardingViewModel()
    @StateObject var onboardingViewModel: OnBoardingViewModel
    
//    var friendUids: [String]? = ["AcBafb", "DYYGUP"] // dummy data
    @Binding var isPresentationMode: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text("최종 저축내용을 확인해주세요")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 24, weight: .bold))
                .padding(.bottom, 58)
            
            ZStack {
                Circle()
                    .stroke().fill(ColorStyle.blue.color)
                    .frame(width: 230, height: 230)
                Image(Product.productDictionary[userViewModel.userData.saveInfo.goalProduct]?.imageUrl ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 110, height: 110)
            }
            .padding(.bottom, 16)
            
            HStack(spacing: 0) {
                Text(String(userViewModel.userData.saveInfo.goalWeeks))
                    .font(.system(size: 20, weight: .bold))
                Text("주간")
                    .font(.system(size: 20, weight: .regular))
                    .padding(.trailing, 4)
                Text(String(Int(Product.productDictionary[userViewModel.userData.saveInfo.goalProduct]?.productPrice ?? 0 * 10000)))
                    .font(.system(size: 20, weight: .bold))
            }
            .foregroundColor(ColorStyle.blackHundred.color)
            .padding(.bottom, 50)
            
            HStack(alignment: .bottom, spacing: 0) {
                Text("매주 \(String(userViewModel.userData.saveInfo.savingDayOfTheWeek))요일")
                    .foregroundColor(ColorStyle.blackHundred.color)
                    .font(.system(size: 22, weight: .bold))
                    .padding(.trailing, 10)
                Text("\(String(userViewModel.userData.saveInfo.savingAmountOfWeek))만원")
                    .foregroundColor(ColorStyle.blue.color)
                    .font(.system(size: 32, weight: .bold))
            }
            .padding(.bottom, 8)
            
            HStack {
                Text(lastOnboardingViewModel.changeDateFormat(date: stringToDate(date: userViewModel.userData.saveInfo.startDate)))
                Text("-")
                Text(lastOnboardingViewModel.calculateDate(date: stringToDate(date: userViewModel.userData.saveInfo.startDate),
                                                           goalWeeks: userViewModel.userData.saveInfo.goalWeeks))
            }
            .foregroundColor(ColorStyle.blackSixty.color)
            .font(.system(size: 16, weight: .regular))
            .padding(.bottom, 30)
            
            if !userViewModel.friendNicknames.isEmpty {
                HStack(spacing: 10) {
                    ForEach(userViewModel.friendNicknames, id:\.self) { nickName in
                        VStack(spacing: 0) {
                            ZStack {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .foregroundColor(ColorStyle.blue.color)
                                    .frame(width: 29, height: 31)
                                Circle()
                                    .stroke().fill(ColorStyle.blue.color)
                                    .frame(width: 60, height: 60)
                            }
                            .padding(.bottom, 2)
                            
                            Text(String(nickName))
                                .foregroundColor(ColorStyle.blackHundred.color)
                                .font(.system(size: 14, weight: .regular))
                        }
                    }
                }
                .padding(.bottom, 45)
            } else {
                HStack {}
                    .padding(.bottom, 124)
            }
            
            Spacer()
            Button {
                isPresentationMode = false
            } label: {
                Text("저축내용을 수정할게요")
                    .foregroundColor(ColorStyle.blackSixty.color)
                    .font(.system(size: 18, weight: .regular))
            }
            .padding(.bottom, 18)
            Button {
                userViewModel.launch()
                onboardingViewModel.setNotFirstOn()
            } label: {
                Text("저축 시작하기")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .regular))
                    .padding(.horizontal, 125.5)
                    .padding(.vertical, 12)
            }
            .background(
                RoundedRectangle(cornerRadius: 30).fill(ColorStyle.blue.color)
            )
        }
        .padding(.horizontal, 20)
    }
}
