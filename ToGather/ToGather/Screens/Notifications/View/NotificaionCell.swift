//
//  NotificaionCell.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/14.
//

import SwiftUI
import Firebase
struct NotificaionCell: View {
    
    let notification : Notification
    let color : Color? = .clear
    var body: some View {
        
        switch notification.type {
        case .newFriend:
            newFriendCell
                .frame(minWidth:0,
                       maxWidth: .infinity,
                       alignment:  .leading)
                .padding(.horizontal)
                .padding(.vertical,16)
                .background(Color.pointColor.opacity(0.05))
        case .mySavingDay:
            mySavingDayCell
                .frame(minWidth:0,
                       maxWidth: .infinity,
                       alignment:  .leading)
                .padding(.horizontal)
                .padding(.vertical,16)
                .background(Color.pointColor.opacity(0.05))
        case .friendSavigState:
            friendSavigStateCell
                .frame(minWidth:0,
                       maxWidth: .infinity,
                       alignment:  .leading)
                .padding(.horizontal)
                .padding(.vertical,16)
        }
        
    }
}

struct NotificaionCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificaionCell(notification: Notification(username: "Max",
                                                   profileImageUrl: "",
                                                   timestamp: Timestamp(date:Date()),
                                                   type: .friendSavigState,
                                                   uid: ""))
    }
}

extension NotificaionCell {
    
    var newFriendCell: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Group {
                    Text(notification.username).bold() +
                    Text("님 친구가 되었어요!")
                }
                .font(.system(size: 14))
                
                Text("오늘")
                    .font(.system(size: 12))
                    .foregroundColor(.basicBlack.opacity(0.6))
                
            }
            HStack {
                Group {
                    Text("이제 ") +
                    Text(notification.username).bold() +
                    Text("님과 저축현황을 함께 공유해요")
                }
                .font(.system(size: 14))
            }
            
        }
        
    }
    
    var mySavingDayCell: some View {
        
        VStack(alignment: .leading,spacing: 10){
            HStack {
                Text("오늘은 저축하는 날이에요!")
                    .font(.system(size: 14))
                Text("1일 전")
                    .font(.system(size: 12))
                    .foregroundColor(.basicBlack.opacity(0.6))
            }
            VStack(alignment: .leading,spacing: 3) {
                Text("13회차")
                    .font(.system(size: 14,weight: .bold))
                    .foregroundColor(.pointColor)
                HStack(spacing: 2){
                    Text("100,000").font(.callout).bold()
                    Text("을 저축해주세요").font(.system(size: 14))
                }
            }
        }
    }
    
    var friendSavigStateCell: some View {
        HStack(spacing: 46){
            VStack(alignment: .leading,spacing:14){
                //알림글
                VStack(alignment: .leading,spacing: 8){
                    HStack {
                        Group {
                            Text("Cook") +
                            Text(" 11번째") +
                            Text(" 저축을 완료했어요")
                        }.font(.system(size: 14))
                        
                        Text("1일 전")
                            .font(.system(size: 12))
                            .foregroundColor(.basicBlack.opacity(0.6))
                        
                    }
                    HStack {
                        Text("지금까지 모은 돈")
                            .font(.system(size: 14))
                        Text("2,300,000")
                            .font(.callout)
                            .foregroundColor(.basicGreen)
                            .bold()
                    }
                }
                // 저축완료율
                VStack(alignment: .leading,spacing: 1) {
                    Text("저축 완료율")
                        .font(.system(size: 12))
                        .foregroundColor(.basicBlack.opacity(0.6))
                    HStack{
                        //수정필요
                        CustomProgressBar(currentProgress: 0.5, color: .basicGreen)
                            .frame(width: 200,height: 10)
                        
                        Text("83%")
                            .font(.system(size: 14, weight: .bold))
                    }
                    
                }
                
                
            }
            //인증 사진
            Image("test")
                .resizable()
                .frame(width: 60, height: 80)
                .cornerRadius(10)
            
        }
    }
}
