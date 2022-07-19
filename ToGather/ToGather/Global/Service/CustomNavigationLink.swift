//
//  Temp1.swift
//  ToGather
//
//  Created by hyo on 2022/07/19.
//

import SwiftUI

struct CustomNavigationLink<DestinationView, ContentView>: View where ContentView: View, DestinationView: View {
    
    var destination: DestinationView
    var isActvie: Binding<Bool> = .constant(true)
    var label: () -> ContentView
    
    var body: some View {
        NavigationLink(isActive: isActvie, destination: {
            destination
                .navigationBarItems(leading: ArrowBackButton())
                .navigationBarBackButtonHidden(true)
        }){
            label()
        }
    }
    
    // let button = Button {~} 할때는 빌드는 되지만 뒤로가기가 되지 않았음. 아마도 초기화 시점이 문제지 않을까 싶다.
    struct ArrowBackButton: View {
        @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        
        var body: some View {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "arrow.backward")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(Color.red)
            }
        }
    }
}

struct CustomNavigationLink_Previews: PreviewProvider {
    
    struct NormalThirdPage: View {
        var body: some View {
            Text("세번째 페이지 컨텐츠 내용")
                .navigationTitle("세번째 페이지")
        }
    }
    
    struct TempSecondPage: View {
        var body: some View {
            CustomNavigationLink(destination: NormalThirdPage()) {
                Text("두번째 페이지 컨텐츠 내용")
                    .navigationTitle("두번째 페이지")
            }
        }
    }
    
    static var previews: some View {
        NavigationView {
            CustomNavigationLink(destination: TempSecondPage(), isActvie: .constant(false)) {
                Text("첫번째 페이지")
            }
        }
    }
}

