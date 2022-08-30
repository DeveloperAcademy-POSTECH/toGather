//
//  SavingRecordView.swift
//  ToGather
//
//  Created by yeongwoocho on 2022/06/15.
//

import SwiftUI


struct SavingRecordView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var userViewModel: UserViewModel
    var user: User {userViewModel.userData}

    var saving: Saving {user.saveInfo}
   
    // product
    var productImageUrl: String {Product.productDictionary[user.saveInfo.goalProduct]?.imageUrl ?? ""}
    var productPrice: Double {Product.productDictionary[user.saveInfo.goalProduct]?.productPrice ?? 0}
    
    var savingDay: String {user.saveInfo.savingDayOfTheWeek}
    var currentWeek: Int {user.saveInfo.currentWeek}

    
    var savingAmountOfWeek: Double {user.saveInfo.savingAmountOfWeek}
    var totalSavingAmount: Double {user.saveInfo.totalSavingAmount}

    @State var showImagePicker: Bool = false
    @State var uiImage: UIImage? = nil
  
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
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
                    Text("\(getToday()) \(savingDay)요일")
                        .font(.system(size: 20))
                    Text("\(currentWeek)회차")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(.pointColor)
                }
                Spacer()
                    .frame(height: 50)
                Text("이번주 저축할 돈")
                Text("\(numberFormatUnitOfManwon(value : savingAmountOfWeek))")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
            }
            if let uiImage = uiImage, let image = Image(uiImage: uiImage){
                
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
                        self.uiImage = nil
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
                            self.uiImage = image
                        }
                    }
            }
            Spacer()
            HStack(alignment: .bottom, spacing: 6) {
                Text("지금까지 모은 돈")
                    .font(.system(size: 14))
                Text("\(numberFormatUnitOfManwon(value : totalSavingAmount))")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.pointColor)
            }
            .padding(.bottom, 16)
            Button(action: {
                guard let uiImage = uiImage else {
                    return
                }
                FirebaseManager.shared.uploadAuthPicAndDidSave(uiImage, to: userViewModel.userData, currentWeek: currentWeek)
                userViewModel.userData.saveInfo.weekInfo[currentWeek - 1].date = dateToString(date: Date())
                userViewModel.userData.saveInfo.weekInfo[currentWeek - 1].didSave = true
                userViewModel.requestAuthPics()
                // image 파일이 존재할 때 Firebase에 쓰는 기능
                presentationMode.wrappedValue.dismiss()
                print("이번주 저축 완료하기")
                
            }, label: {
                Text("이번주 저축 완료하기")
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 46)
                    .foregroundColor(.white)
                    .background(uiImage != nil ? Color.pointColor : Color.black03)
                    .cornerRadius(30)
                    .padding(.horizontal, 20)
            })
            .disabled(uiImage == nil ? true : false)
        } // VStack
    }
}

struct SavingRecordView_Previews: PreviewProvider {
    static var previews: some View {
        SavingRecordView(showImagePicker: false, uiImage: nil).environmentObject(userViewModel)
    }
}
