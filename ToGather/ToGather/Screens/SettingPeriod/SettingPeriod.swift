//
//  ContentView.swift
//  test1
//
//  Created by hyo on 2022/06/08.
//

import SwiftUI

// 더미 데이터
let product = Product(productName: "imac", productPrice: 180, imageUrl: "imac")

struct SettingPeriodView: View {
    @State private var selectedDay: String?
    @State private var numWeek: Double = 1.0
    private var savePeriod: Double { numWeek * 4}
    private var saveMoney: Double { product.productPrice/(numWeek)/4}

    var body: some View {
        VStack {
            Spacer(minLength: 90)
            title
            Spacer(minLength: 16)
            itemInfo
            Spacer(minLength: 50)
            slider
            Spacer(minLength: 15)
            selectDay
            Spacer(minLength: 70)
            nextButton
        }.ignoresSafeArea()
    }

    private let title: some View = HStack {
        VStack(alignment: .leading) {
            HStack {
                Text("매주 저축할 금액").foregroundColor(ColorStyle.blue.color) + Text("과 ")
                Text("요일").foregroundColor(ColorStyle.blue.color) + Text("을")
            }
            Text("골라주세요")
        }.font(.system(size: 24, weight: .bold))
        .padding(.horizontal, 20)
        Spacer()
    }

    private let itemInfo: some View = VStack {
        ZStack {
            // 바닥부터 시작
            Image(product.imageUrl).resizable()
                .scaledToFit()
                .frame(width: 101, height: 91)
            Circle().stroke().fill(ColorStyle.blue.color)
                .frame(width: 170, height: 170, alignment: .center)

        }.padding(EdgeInsets(top: 0, leading: 0, bottom: 13, trailing: 0))
        Text("총 \(product.productPrice, specifier: "%3.f")만원").font(.system(size: 16, weight: .medium))
    }

    private var slider: some View {
        let priceAndPeriod: some View = Text("매주 ")
                                        + Text("\(saveMoney, specifier: "%4.f")")
                                            .foregroundColor(ColorStyle.blue.color)
                                            .font(.system(size: 26, weight: .bold))
                                        + Text("만원")
                                            .foregroundColor(ColorStyle.blue.color)
                                            .font(.system(size: 26, weight: .bold))
                                        + Text("    기간 ")
                                        + Text("\(savePeriod, specifier: "%3.f")")
                                            .foregroundColor(ColorStyle.blue.color)
                                            .font(.system(size: 26, weight: .bold))
                                        + Text("주").foregroundColor(ColorStyle.blue.color)
                                            .font(.system(size: 26, weight: .bold))

        let sliderInfo: some View = VStack {
            HStack {
                Text("1")
                Spacer()
                Text("11")
            }
            .font(.system(size: 14, weight: .bold))
            .padding(.horizontal, 17)
            HStack {
                Spacer()
                Text("48주")
                    .foregroundColor(ColorStyle.blue.color)
                    .padding(EdgeInsets(top: 3, leading: 10, bottom: 0, trailing: 10))
            }
        }

        return VStack {
            priceAndPeriod
            Spacer(minLength: 30)
            Text("약 \(numWeek, specifier: "%2.f")개월")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(ColorStyle.blackSixty.color)
            Slider(value: $numWeek, in: 1...12, step: 1)
                .padding(.horizontal, 17)
                .accentColor(ColorStyle.blue.color)
            sliderInfo
        }.font(.system(size: 16, weight: .bold))
    }

    private let days = ["월", "화", "수", "목", "금", "토", "일"]

    private var selectDay: some View {
        VStack {
            HStack {
                Text("저축할 요일").font(.system(size: 24, weight: .bold))
                Spacer()
            }.padding(.horizontal, 20)
            Spacer(minLength: 34)
            HStack {
                ForEach(days, id: \.self) { day in
                    if day == selectedDay {
                        ZStack {
                            Circle().stroke().fill(ColorStyle.blue.color)
                                .frame(width: 40, height: 40, alignment: .center)
                            Text("\(day)")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(ColorStyle.blue.color)
                                .padding(EdgeInsets(top: 10, leading: 13, bottom: 13, trailing: 13))
                        }
                    } else {
                        ZStack {
                            Text("\(day)")
                                .font(.system(size: 20, weight: .medium))
                                .padding(EdgeInsets(top: 10, leading: 13, bottom: 13, trailing: 13))
                                .onTapGesture {
                                    selectedDay = day
                            }
                        }
                    }
                }
            }.padding(.horizontal, 10)
        }
    }

    private var nextButton: some View {
            return VStack {
            NavigationLink(destination: EmptyView()) {
                ZStack {
                    if selectedDay != nil {
                        RoundedRectangle(cornerRadius: 30)
                                .foregroundColor(ColorStyle.blue.color)
                                .frame(width: 350, height: 46, alignment: .center)
                        Text("다음").foregroundColor(.white)
                            .fontWeight(.semibold)
                    } else {
                        RoundedRectangle(cornerRadius: 30)
                                .foregroundColor(ColorStyle.blackTen.color)
                                .frame(width: 350, height: 46, alignment: .center)
                        Text("다음").foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
            }
            Spacer(minLength: 36)
        }
    }
}

var temp : some View = ZStack {
        SettingPeriodView()
//        Image("저축기간").opacity(0.9)
}

struct SettingPeriodView_Previews: PreviewProvider {
    static var previews: some View {
        // temp
        NavigationView {
            NavigationLink(destination: temp) {
                Text("링크 확인")
            }
        }
    }
}
