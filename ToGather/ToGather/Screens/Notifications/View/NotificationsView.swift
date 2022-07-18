//
//  NotificationsView.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/14
//

import SwiftUI
import Firebase

struct NotificationsView: View {
    
    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = NotificationsViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment:.leading,spacing: 0) {
                    ForEach(viewModel.notification,id: \.id) { notification in
                        // FIXME: - 친구에 따른 컬러부분 수정필요
                        NotificaionCell(notification: notification, friendColor: .friendGreen01)
                    }
                }
                .navigationTitle("알림")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    // back button
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

// MARK: - Preview
struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}

// MARK: - 커스텀네비게이션 백버튼 스와이프 가능하게 하는 코드
extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
