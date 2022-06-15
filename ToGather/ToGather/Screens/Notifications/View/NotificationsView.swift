//
//  NotificationsView.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/14.
//

import SwiftUI
import Firebase

struct NotificationsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack(alignment:.leading,spacing: 0) {
                    
                    
                    
                    NotificaionCell(notification: Notification(username: "Max",
                                                                   profileImageUrl: "",
                                                                   timestamp: Timestamp(date:Date()) ,
                                                                   type: .newFriend,
                                                                   uid: ""))
                    NotificaionCell(notification: Notification(username: "Max",
                                                               profileImageUrl: "",
                                                               timestamp: Timestamp(date:Date()) ,
                                                               type: .mySavingDay,
                                                               uid: ""))
                    NotificaionCell(notification: Notification(username: "Max",
                                                               profileImageUrl: "",
                                                               timestamp: Timestamp(date:Date()) ,
                                                               type: .friendSavigState,
                                                               uid: ""))
                    
                    NotificaionCell(notification: Notification(username: "Max",
                                                               profileImageUrl: "",
                                                               timestamp: Timestamp(date:Date()) ,
                                                               type: .mySavingDay,
                                                               uid: ""))
                    
                    NotificaionCell(notification: Notification(username: "Max",
                                                               profileImageUrl: "",
                                                               timestamp: Timestamp(date:Date()) ,
                                                               type: .friendSavigState,
                                                               uid: ""))
                    
                }
                .navigationTitle("알림")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "arrow.backward")
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(Color.basicBlack)
                            
                        }
                        
                    }
                }
                
            }
            
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}

// 커스텀네비게이션 백버튼 스와이프 가능하게 하는 코드
extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
