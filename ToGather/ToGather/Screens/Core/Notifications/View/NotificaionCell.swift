//
//  NotificaionCell.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/14.
//

import SwiftUI
import Firebase
struct NotificaionCell: View {
    
    // MARK: - Properties
    let notification : Notification
    let friendColor : Color
    
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

// MARK: - Preview
struct NotificaionCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificaionCell(notification: Notification(username: "Max",
                                                   authPicUrl: "",
                                                   timestamp: Timestamp(date:Date()),
                                                   type: .friendSavigState,
                                                   uid: ""), friendColor: .friendGreen01)
    }
}

// MARK: - Extension for subviews
extension NotificaionCell {
    // 새로운 친구 알림
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
    // 저축일 알림
    var mySavingDayCell: some View {
        
        VStack(alignment: .leading,spacing: 10) {
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
                HStack(spacing: 2) {
                    Text("100,000").font(.callout).bold()
                    Text("을 저축해주세요").font(.system(size: 14))
                }
            }
        }
    }
    // 친구저축상태 알림
    var friendSavigStateCell: some View {
        HStack(spacing: 46) {
            VStack(alignment: .leading,spacing:14) {
                // 알림글
                VStack(alignment: .leading,spacing: 8) {
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
                            .foregroundColor(self.friendColor)
                            .bold()
                    }
                }
                // 저축완료율
                VStack(alignment: .leading,spacing: 1) {
                    Text("저축 완료율")
                        .font(.system(size: 12))
                        .foregroundColor(.basicBlack.opacity(0.6))
                    HStack {
                        // FIXME: - 수정필요
                        CustomProgressBar(currentProgress: 0.5, color: self.friendColor)
                            .frame(width: 200,height: 10)
                        
                        Text("83%")
                            .font(.system(size: 14, weight: .bold))
                    }
                    
                }
                
            }
            // TODO: - 친구 인증 사진 연동해야함.
            Image("test")
                .resizable()
                .frame(width: 60, height: 80)
                .cornerRadius(10)
            
        }
    }
}
