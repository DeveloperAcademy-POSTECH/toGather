//
//  SettingView.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/17.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userViewModel : UserViewModel
    @State var isMyBellOn = false
    @State var isFriendBellOn = false

    var body: some View {
        NavigationView {
            VStack(spacing: 4) {
                
                Spacer()
                    .frame(height:10)
                HStack {
                Text("프로필")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.basicBlack)
                        .padding(.bottom,4)
                    Spacer()
                }
                Divider()
                HStack {
                Text("닉네임")
                        .font(.callout)
                        .padding(.bottom,4)
                    
                Text("6자 이내")
                        .font(.system(size: 14))
                        .foregroundColor(.black02)
                    Spacer()
                }
                HStack(spacing:14){
                Text("MadMax")
                        .font(.system(size: 20, weight: .bold))

                    Button {
                        
                    } label: {
                        Text("수정")
                            .frame(width: 41, height: 22)
                            .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.pointColor, lineWidth: 0.5))

                }
                    
                    Spacer()
            }
                
                Spacer()
                    .frame(height: 30)
                HStack(spacing:4) {
                Text("고유 ID ").font(.callout)
                Text("친구를 추가해주세요")
                    .font(.system(size: 14))
                    .foregroundColor(.black02)
                    
                    Spacer()
                }
                
                HStack {
                
                    ForEach(0..<6) { digit in
                        Text("0")
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
                }
                
                Text("알림")
                Divider()
                
                HStack {
                    VStack{
                        
                    }
                    Toggle(isOn: $isMyBellOn) {
                        <#code#>
                    }
                }
                
                
                
                Spacer()
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

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
