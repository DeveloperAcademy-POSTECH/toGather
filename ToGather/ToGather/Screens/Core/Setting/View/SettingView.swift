//
//  SettingView.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/17.
//

import SwiftUI


struct SettingView: View {
    
    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userViewModel : UserViewModel
    @State var isMyBellOn = true
    @State var isFriendBellOn = true
        
    var body: some View {
        NavigationView {
            VStack(spacing: 60) {
                
                profileView
                notifiView
                themaView
                
            }
            .navigationTitle("설정")
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
            .padding(.horizontal)
        }
        
    }
}

// MARK: - Extension
extension SettingView {
    
    var profileView : some View {
        VStack(spacing:0) {
            
            HStack {
                Text("프로필")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.basicBlack)
                Spacer()
            }
            .padding(.bottom,4)
                
            Divider()
                .padding(.bottom,16)
            
            HStack {
                Text("닉네임")
                    .font(.callout)
                
                Text("6자 이내")
                    .font(.system(size: 14))
                    .foregroundColor(.black02)
                Spacer()
            }
            .padding(.bottom,10)
            
            HStack(spacing:14) {
                Text("\(userViewModel.userData.nickname) ")
                    .font(.system(size: 20, weight: .bold))
                
                Button {
                    
                } label: {
                    Text("수정")
                        .font(.system(size: 12))
                        .frame(width: 41, height: 22)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.pointColor, lineWidth: 0.5))
                }
                Spacer()
            }
            .padding(.bottom,30)
                                    
            HStack(spacing:4) {
                Text("고유 ID ").font(.callout)
                Text("친구를 추가해주세요")
                    .font(.system(size: 14))
                    .foregroundColor(.black02)
                
                Spacer()
            }.padding(.bottom,11)
            
            HStack {
                
                ForEach(userViewModel.userData.id!.map {String($0)},id: \.self
                ) { ch in
                    
                    Text(ch)
                        .font(.system(size: 18, weight: .bold))
                        .frame(width: 46, height: 46)
                        .foregroundColor(.pointColor)
                    
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(.blue, lineWidth: 1.5)
                                .frame(width: 46, height: 46)
                                .foregroundColor(.pointColor)
                            
                        )
                }
                Spacer()
            }
        }
    }
    
    var notifiView : some View {
        VStack(spacing: 0) {
            HStack {
                Text("알림")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
            }.padding(.bottom,4)
            Divider()
                .padding(.bottom,16)
            
            HStack {
                VStack(alignment: .leading,spacing: 4) {
                    Text("저축 알림 받기")
                        .font(.callout)
                        .bold()
                    Text("저축 당일 알림이 와요")
                        .foregroundColor(.black02)
                        .font(.system(size: 14))
                }
                Toggle(isOn: $isMyBellOn) {}                    .tint(.pointColor)
                
            }
            .padding(.bottom,20)
            
            HStack {
                VStack(alignment: .leading,spacing: 4) {
                    Text("친구 저축 알림 받기")
                        .font(.callout)
                        .bold()
                    Text("친구가 저축을 하면 알림이 와요")
                        .foregroundColor(.black02)
                        .font(.system(size: 14))
                }
                Toggle(isOn: $isFriendBellOn) {}
                    .tint(.pointColor)
            }
        }
    }
    
    var themaView : some View {
        VStack(spacing:0) {
            HStack {
                Text("테마")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
            }
            .padding(.bottom,4)
            
            Divider()
                .padding(.bottom,16)
            
            VStack(spacing: 20) {
                DisplayModeView(displayMode: .system,
                                title: "시스템 설정")
                DisplayModeView(displayMode: .light,
                                title: "라이트 모드")
                DisplayModeView(displayMode: .dark,
                                title: "다크 모드")
            }
        }
    }
}
// MARK: - Preview
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
