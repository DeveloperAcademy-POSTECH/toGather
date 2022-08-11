import SwiftUI
import Kingfisher

struct FrSavingStatusNavigationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var user: User
    var colorRGB: RGBColorInProgressCircle
    var color: Color {colorRGB.start}
    var body: some View {
        let backButton = Button {presentationMode.wrappedValue.dismiss()} label: {
            Image(systemName: "arrow.backward")
                .font(.system(size: 22, weight: .medium))
                .foregroundColor(Color.basicBlack)
        }
        
        return NavigationView {
            FrSavingStatusView(user: user, colorRGB: colorRGB)
                .navigationBarItems(leading: backButton)
                .navigationTitle("\(user.nickname) 저축현황")
        }
    }
}

struct FrSavingStatusView: View {
    
    @State var isPhotoEdited: Bool = false
    @State var dummyImage: [(String, String)] = [("6:13", "1주전"), ("6:6", "2주전"), ("5:30", "3주전")]
    var user: User
    var colorRGB: RGBColorInProgressCircle
    var color: Color {colorRGB.start}
    
    var saving: Saving {user.saveInfo}
    var goalWeek: Int {user.saveInfo.goalWeeks}
    var productImageUrl: String {Product.productDictionary[user.saveInfo.goalProduct]?.imageUrl ?? ""}
    var productPrice: Double {Product.productDictionary[user.saveInfo.goalProduct]?.productPrice ?? 0}
    var progressPercent: Double {user.saveInfo.progressPercent}
    var lastDate: String {user.saveInfo.lastDate}
    var startDate: String {user.saveInfo.startDate}
    var savingDay: String {user.saveInfo.savingDayOfTheWeek}
    var savingAmountOfWeek: Double {user.saveInfo.savingAmountOfWeek}
    var totalSavingAmount: Double {user.saveInfo.totalSavingAmount}
    var goalSavingAmount: Double {user.saveInfo.goalSavingAmount}
    var currentWeek: Int {user.saveInfo.currentWeek}
    var totalFailedNum: Int {user.saveInfo.totalFailedNum}
    var totalSavedNum: Int {user.saveInfo.totalSavedNum}
    var isDueExtended: Bool {totalFailedNum != 0 ? true : false}
    
    var authPics: [String] {
        var result: [String] = []
        user.saveInfo.weekInfo.forEach { thisWeek in
            if let imageUrl = thisWeek.imageUrl {
                result.append(imageUrl)
            }
        }
        return result
    }
    
    var authPicsDate: [String] {
        var result: [String] = []
        user.saveInfo.weekInfo.forEach { thisWeek in
            if let date = thisWeek.date {
                result.append(date)
            }
        }
        return result
    }
    
    var authPicsDateDiff: [String] {
        let nowStr = dateToString(date: Date())
        let currentDate = stringToDate(date: nowStr)
        
        var dateDiff: [String] = []
        authPicsDate.forEach { element in
            let created = stringToDate(date: element)
            let diff = Calendar.current.dateComponents([.day, .weekOfYear], from: created, to: currentDate)
            
            if let week = diff.weekOfYear, let day = diff.day {
                if week != 0 {
                    dateDiff.append("\(week)주전")
                } else {
                    dateDiff.append(day == 0 ? "오늘" : "\(day)일전")
                }
            }
            
        }
        
        return dateDiff
    }
    
    var isMine: Bool = true
    
    var body: some View {
        ScrollView {
            VStack {
                fRsavingRate
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                fRcurrentSavingMoney
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 40, trailing: 0))
                fRsuccessCount
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 40, trailing: 0))
                fRdueDate
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 80, trailing: 0))
                fRsavingSuccess
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 4, trailing: 20))
                fRSuccessPictureGrid
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 60, trailing: 20))
                
                fRtwoButtons
                    .padding(EdgeInsets(top: 80, leading: 64, bottom: 64, trailing: 40))
            }
        }
    }
}

extension FrSavingStatusView {
    //  현재 저축 progress bar 및 저축 달성률
    var fRsavingRate: some View {
        HStack {
            
            ProgressCircle(color: colorRGB, frameSize: 130, saving: mySaving)
                .overlay(Image(Product.productDictionary[user.saveInfo.goalProduct]?.imageUrl ?? ""))
            fRsavingText.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
        }.padding(EdgeInsets(top: 28, leading: 19, bottom: 0, trailing: 0))
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity,
                   minHeight: 0, idealHeight: 122, maxHeight: 122, alignment: .topLeading)
    }
    //    저축 달성률에 관한 Text
    var fRsavingText: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("저축완료일")
                .foregroundColor(.basicBlack.opacity(0.6))
                .font(.system(size: 14))
            Text("\(progressPercent, specifier: "%.f")%")
                .foregroundColor(color)
                .font(.system(size: 40))
                .fontWeight(.bold)
            Spacer(minLength: 5)
            Text("매주 \(savingDay)요일 ").font(.system(size: 18)).fontWeight(.bold) +
            Text("\(savingAmountOfWeek, specifier: "%3.1f")만원").foregroundColor(color)
                .font(.system(size: 18))
        }
    }
    //    현재까지 저축한 금액
    var fRcurrentSavingMoney: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("지금까지 모은돈").foregroundColor(.basicBlack.opacity(0.6)).font(.system(size: 16))
                Text("\(numberFormatUnitOfManwon(value: totalSavingAmount))").font(.system(size: 24)).fontWeight(.bold).foregroundColor(.basicBlack)
                + Text(" / \(numberFormatUnitOfManwon(value: goalSavingAmount))").font(.system(size: 24)).fontWeight(.medium).foregroundColor(.basicBlack.opacity(0.6))
            }
            Spacer()
        }
    }
    //    저축 성공 횟수
    var fRsuccessCount: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("저금 성공").font(.system(size: 16)).foregroundColor(.basicBlack.opacity(0.6))
                Text("\(currentWeek)회 ").font(.system(size: 24)).foregroundColor(.basicBlack).fontWeight(.bold)
                + Text("/ \(goalWeek)").font(.system(size: 20))
                    .foregroundColor(.basicBlack.opacity(0.6)).fontWeight(.bold)
            }
            Spacer()
        }
    }
    //    원하는 금액까지 저축기간
    var fRdueDate: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("저축 기간").font(.system(size: 16)).foregroundColor(.basicBlack.opacity(0.6))
                HStack(alignment: .center, spacing: 6) {
                    Text("\(dateFormatter(date: startDate)) - \(dateFormatter(date:lastDate))")
                        .font(.system(size: 18))
                        .foregroundColor(.basicBlack)
                        .fontWeight(.semibold)
                    Text("| ").font(.system(size: 15))
                    if isDueExtended {
                        Text("\(goalWeek)+ ").font(.system(size: 16))
                        + Text("\(totalFailedNum)주").font(.system(size: 16)).foregroundColor(.red).fontWeight(.bold)
                    } else {
                        Text("\(goalWeek)주")
                    }
                }
                
            }
            Spacer()
        }
    }
    
    var fRsavingSuccess: some View {
        HStack {
            Text("저축 성공 사진")
                .font(.system(size: 16))
                .foregroundColor(color)
            Spacer()
            
//            Button {
//                isPhotoEdited.toggle()
//            } label: {
//                Text( isPhotoEdited ? "편집 완료" : "사진 편집")
//                    .font(.system(size: 14))
//                    .foregroundColor(isPhotoEdited ? .black02 : .alertRed)
//            }
            
        }
    }
    //    저축사진에 관한 Grid
    var fRSuccessPictureGrid: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<authPics.count) { index in
                    VStack(alignment: .trailing) {
                        ZStack(alignment: .topTrailing) {
                            KFImage(URL(string: authPics[index]))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 149, height: 239)
                                .clipShape(Rectangle())
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(lineWidth: 1.5)
                                        .foregroundColor(.clear)
                                }
                                .background(.clear)
                                .cornerRadius(8)
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
//                            if isPhotoEdited {
//                                ZStack(alignment: .topTrailing) {
//                                    Button {
//                                        dummyImage.remove(at: i)
//
//                                    } label: {
//                                        Image(systemName: "minus.circle.fill")
//                                            .foregroundColor(.red)
//                                        //                    .background()
//                                            .font(.system(size: 16))
//                                    }
//                                }
//                            }
                        }
                        Text("\(authPicsDateDiff[index])").foregroundColor(.basicBlack.opacity(0.6)).padding(EdgeInsets(top: 6, leading: 0, bottom: 0, trailing: 10))
                    }
                }
            }
        }
    }
    
    
    var fRtwoButtons: some View {
        HStack {
            Button {
                print("친구를 삭제합니다")
            } label: {
                Text("친구 삭제")
                    .foregroundColor(.red)
                    .fontWeight(.semibold)
                    .font(.system(size: 16))
                    .padding(10)
                    .background(.red.opacity(0.05))
                    .cornerRadius(10)
            }
            Spacer()
            Button {
                print("친구를 삭제합니다")
            } label: {
                HStack {
                    Image(systemName: "bell.slash")
                        .foregroundColor(.basicBlack)
                    Text("\(user.nickname) 알림 끄기")
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                        .foregroundColor(.basicBlack)
                }
                    .padding(10)
                    .background(.black.opacity(0.05))
                    .cornerRadius(10)
                    
            }
            
        }
    }
}

