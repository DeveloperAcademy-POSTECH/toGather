//
//  SavingRecordView.swift
//  ToGather
//
//  Created by yeongwoocho on 2022/06/15.
//

import SwiftUI

struct SavingRecordView: View {
    @State var showImagePicker: Bool = false
    @State var image: Image? = nil
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Button(action: {
                    print("x mark")
                }, label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 24))
                        .foregroundColor(.basicBlack)
                })
                .padding(20)
            }
            Spacer()
                .frame(height: 44)
            VStack(alignment: .center, spacing: 0) {
                HStack(alignment: .center, spacing: 6) {
                    Text("7월 31일 목요일")
                        .font(.system(size: 20))
                    Text("13회차")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(.pointColor)
                }
                Spacer()
                    .frame(height: 50)
                Text("이번주 저축할 돈")
                Text("100,000")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
            }
            if let image = image {
                ZStack(alignment: .topTrailing) {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 180, height: 260)
                        .clipShape(Rectangle())
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(lineWidth: 1)
                                .foregroundColor(.clear)
                        }
                        .background(.clear)
                        .cornerRadius(10)
                        .padding(20)
                    Circle()
                        .fill(.white)
                        .frame(width: 20, height: 20)
                        .padding(10)
                    Button {
                        self.image = nil
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .frame(width: 20, height: 20)
                            .clipShape(Circle())
                            .foregroundColor(.alertRed)
                    }
                    .padding(10)
                    
                }
            } else {
                Rectangle()
                    .frame(width: 180, height: 260)
                    .foregroundColor(.clear)
                    .cornerRadius(10)
                    .background(.clear)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(lineWidth: 1)
                            .foregroundColor(.pointColor)
                        VStack(alignment: .center, spacing: 8) {
                            Image(systemName: "plus")
                                .font(.system(size: 30))
                                .foregroundColor(.pointColor)
                            Text("저축 계좌로\n송금한 사진")
                        }
                    }
                    .padding(20)
                    .onTapGesture {
                        self.showImagePicker.toggle()
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(sourceType: .photoLibrary) { image in
                            self.image = Image(uiImage: image)
                        }
                    }
            }
            HStack(alignment: .center, spacing: 6) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.pointColor)
                Text("친구한테 알리기")
            }
            Spacer()
            HStack(alignment: .bottom, spacing: 6) {
                Text("지금까지 모은 돈")
                    .font(.system(size: 14))
                Text("1,300,000")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.pointColor)
            }
            .padding(.bottom, 16)
            Button(action: {
                guard let _ = image else {
                    return
                }
                // image 파일이 존재할 때 Firebase에 쓰는 기능
                print("이번주 저축 완료하기")
            }, label: {
                Text("이번주 저축 완료하기")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 46)
                    .foregroundColor(.white)
                    .background(image != nil ? Color.pointColor : Color.black03)
                    .cornerRadius(30)
                    .padding(.horizontal, 20)
            })
        } // VStack
    }
}

struct SavingRecordView_Previews: PreviewProvider {
    static var previews: some View {
        SavingRecordView(showImagePicker: false, image: nil)
    }
}
