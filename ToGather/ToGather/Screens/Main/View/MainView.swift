//
//  MainView.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/09.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                friendsSavingsView
                    .padding()
                
                Divider()
                    .padding(.horizontal)
                    .padding(.bottom)
                
                mySavingsView
                Spacer(minLength: 68)
                bottomView
               // Spacer()
        }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Text("친구 저축현황")
                        .font(.system(size: 22, weight: .bold))

                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        //
                    } label: {
                        Image(systemName: "bell.badge.fill")
                    }
                    .foregroundColor(.baseBlack.opacity(0.4))
                    Button {
                        //
                    } label: {
                        Image(systemName: "gear")
                    }
                    .foregroundColor(.baseBlack.opacity(0.4))

                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension MainView {
    var friendsSavingsView : some View {
        ZStack {
            VStack {
            HStack(spacing:26){
                FriendSavingView(image: "Ipad",
                                 percentage: 0.56,
                                 colors: [
                    Color(red: 0.779, green: 0.097, blue: 0.248, opacity: 1),
                      Color(red: 0.918, green: 0.298, blue: 0.435, opacity: 1)
                          ],
                                 backgroundColor: Color.lightRed2,
                                 unfillColor: Color.lightRed,
                                 friendName: "Tim")
                FriendSavingView(image: "Iphone",
                                 percentage: 0.23,
                                 colors: [
                                    Color(red: 0.301, green: 0, blue: 0.642, opacity: 1),
                                      Color(red: 0.757, green: 0.576, blue: 0.961, opacity: 1)
                                          ] ,
                                 backgroundColor: Color.lightPurple2, unfillColor: Color.lightPurple, friendName: "Steve")
                FriendSavingView(image: "Macbook",
                                 percentage: 0.8,
                                 colors: [
                                    Color(red: 0.056, green: 0.733, blue: 0.046, opacity: 1),

                                      Color(red: 0.581, green: 0.829, blue: 0.176, opacity: 1)
                                          ] ,
                                 backgroundColor: Color.lightGreen2, unfillColor: Color.lightGreen, friendName: "Cook")
            }
            }
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    Text("친구편집")
//                        .font(.subheadline)
//                        .foregroundColor(Color.baseBlack.opacity(0.8))
//                        .padding()
//                }
//                }
        }
    }
    
    var mySavingsView : some View {
        VStack {
            HStack {
                Text("나의 저축현황")
                    .font(.system(size: 22, weight: .bold))
                Spacer()
            }
            .padding(.horizontal)
            ZStack {
                VStack {
                    Image("Imac")
                        .resizable()
                        .frame(width: 86.57, height: 78)
                        .padding(.top, 50)
                    Text("180만원까지")
                        .font(.callout)
                        .foregroundColor(.gray)
                    Text("30%")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(Color(hex: "#468EF3"))
                        .padding(.bottom)
                        
                    Text("저축 완료일")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Text("2022.09.03")
                        .font(.callout)
                        .bold()
                }

                CircleProgress(percentage: 0.3,
                               radius: 310,
                               gradientColors: [
                                Color(hex: "#0043A0"),
                                Color(hex: "#5199FF")
                                                ],
                               backgroundColor: Color.lightBlue2, unfillColor: Color.lightBlue)
                .padding(.horizontal)
                                }
        }
    }
    
    var bottomView : some View {
        VStack {
            HStack{
                Text("13회")
                    .font(.callout)
                    .foregroundColor(Color(hex: "#468EF3"))
                    .bold()
                Text("저축까지 남은 시간")
                    .font(.system(size: 14))
                    .foregroundColor(.baseBlack.opacity(0.6))
            }
                Button {
                //
            } label: {
                Label {
                    Text("6일 20시간 40분")
                        .font(.callout)
                        .foregroundColor(.white)
                } icon: {
                    Image(systemName: "clock")
                        .foregroundColor(.white)
                }

            }
            .frame(minWidth: 0, maxWidth: .infinity,minHeight: 46)
            .background(Color.baseBlack.opacity(0.3))
            .cornerRadius(30)
            .padding(.horizontal)
        }
    }
}


