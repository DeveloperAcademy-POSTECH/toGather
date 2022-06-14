//
//  LastOnboardingView.swift
//  ToGather
//
//  Created by Seungwon Choi on 2022/06/09.
//

import SwiftUI

struct LastOnboardingView: View {
    
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    @ObservedObject var lastOnboardingViewModel: LastOnboardingViewModel
    
    var friendUids: [String]? = ["friend1", "friend2"] // dummy data
    
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
                Image(onboardingViewModel.savingData.goalProduct.imageUrl)
            }
            .padding(.bottom, 16)
            
            HStack(spacing: 0) {
                Text(String(onboardingViewModel.savingData.goalWeeks))
                    .font(.system(size: 20, weight: .bold))
                Text("주간")
                    .font(.system(size: 20, weight: .regular))
                    .padding(.trailing, 4)
                Text(String(onboardingViewModel.savingData.goalProduct.productPrice))
                    .font(.system(size: 20, weight: .bold))
            }
            .foregroundColor(ColorStyle.blackHundred.color)
            .padding(.bottom, 50)
            
            HStack(alignment: .bottom, spacing: 0) {
                Text("매주 \(String(onboardingViewModel.savingData.savingDayOfTheWeek))요일")
                    .foregroundColor(ColorStyle.blackHundred.color)
                    .font(.system(size: 22, weight: .bold))
                    .padding(.trailing, 10)
                Text("\(String(onboardingViewModel.savingData.goalProduct.productPrice))만원")
                    .foregroundColor(ColorStyle.blue.color)
                    .font(.system(size: 32, weight: .bold))
            }
            .padding(.bottom, 8)
            
            HStack {
                Text("") // 나중에 timestamp -> string 변환 함수 추가
                Text("-")
                Text("2022.09.03")
            }
            .foregroundColor(ColorStyle.blackSixty.color)
            .font(.system(size: 16, weight: .regular))
            .padding(.bottom, 30)
            
            if friendUids != nil {
                HStack(spacing: 10) {
                    ForEach(friendUids ?? [], id:\.self) { friendUid in
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
                            
                            Text(String(friendUid))
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
            
            Button {
                // 나중에 onboarding 첫페이지로 이동하는 코드 추가
            } label: {
                Text("저축내용을 수정할게요")
                    .foregroundColor(ColorStyle.blackSixty.color)
                    .font(.system(size: 18, weight: .regular))
            }
            .padding(.bottom, 18)
            
            Button {
                onboardingViewModel.addUid()
                onboardingViewModel.uploadSavingDataAndUserData()
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

struct LastOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        LastOnboardingView(lastOnboardingViewModel: LastOnboardingViewModel())
    }
}
