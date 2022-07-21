//
//  SwiftUIView.swift
//  ToGather
//
//  Created by Seungwon Choi on 2022/07/21.
//

import SwiftUI

struct FriendModalView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 2) {
                        Text(dummyFriend1.nickname)
                            .foregroundColor(Color.pointColor)
                        Text("에게 친구신청이 왔어요")
                            .foregroundColor(Color.basicBlack)
                    }
                    .font(.system(size: 22, weight: .bold))
                    .padding(.bottom, 12)
                    Text("같이 저축현황을 공유할까요?")
                        .font(.system(size: 18))
                        .foregroundColor(Color.basicBlack)
                        .padding(.bottom, 48)
                }
                .padding(.leading, 20)
                .padding(.top, 40)
                Spacer()
            }
            AddingFriendProgressCircle(id: 1, user: dummyFriend1, color: RGBColorInProgressCircle.myColor)
                .padding(.bottom, 21)
            HStack(spacing: 4) {
                Text("매주")
                    .fontWeight(.bold)
                Text("\(dummyFriend1.saveInfo.savingDayOfTheWeek)요일")
                    .fontWeight(.bold)
                Text("\(dummyFriend1.saveInfo.savingAmountOfWeek, specifier: "%3.1f")만원")
                    .fontWeight(.bold)
                    .foregroundColor(Color.pointColor)
            }
            .font(.system(size: 18))
            .padding(.bottom, 61)
            HStack(spacing: 30) {
                Button(
                    action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("아니요")
                            .bold()
                            .padding(.horizontal, 51.5)
                            .padding(.vertical, 12)
                            .foregroundColor(Color.basicBlack.opacity(0.6))
                            .background(Color.basicBlack.opacity(0.05))
                            .cornerRadius(10)
                    })
                Button(
                    action: {
                        
                    }, label: {
                        Text("공유할게요")
                            .bold()
                            .padding(.horizontal, 36)
                            .padding(.vertical, 12)
                            .foregroundColor(Color.white)
                            .background(Color.pointColor)
                            .cornerRadius(10)
                    })
            }
        }
    }
}

struct FriendModalView_Previews: PreviewProvider {
    static var previews: some View {
        FriendModalView()
    }
}
