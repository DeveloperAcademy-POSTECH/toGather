//
//  Temp1.swift
//  ToGather
//
//  Created by hyo on 2022/07/19.
//

import SwiftUI

struct CustomNavigationLink<DestinationView, ContentView>: View where DestinationView: View, ContentView: View {
    var destination: DestinationView
    @Binding var isActive: Bool
    var label: () -> ContentView
    var hasIsActive: Bool
    
    init(destination: DestinationView, isActive: Binding<Bool>, label: @escaping () -> ContentView) {
        self.destination = destination
        self._isActive = isActive
        self.label = label
        self.hasIsActive = true
    }
    
    init(destination: DestinationView, label: @escaping () -> ContentView) {
        self.destination = destination
        self.label = label
        self._isActive = .constant(true)
        self.hasIsActive = false
    }
    
    var body: some View {
        if hasIsActive {
            NavigationLink(isActive: $isActive, destination: {
                destination
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading: ArrowBackButton())
                    .navigationBarBackButtonHidden(true)
            }){
                label()
            }
        } else {
            NavigationLink(destination: {
                destination
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading: ArrowBackButton())
                    .navigationBarBackButtonHidden(true)
            }){
                label()
            }
        }
      
    }
    
    struct ArrowBackButton: View {
        @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        
        var body: some View {
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

struct CustomNavigationLink_Previews: PreviewProvider {
    struct NormalThirdPage: View {
        @Binding var isActive: Bool
        
        var body: some View {
            VStack {
                Text("세번째 페이지 컨텐츠 내용")
                    .navigationTitle("세번째 페이지")
                Button {
                    isActive = false
                } label: {
                    Text("click")
                }
            }
            
        }
    }
    
    struct TempSecondPage: View {
        @Binding var isActive: Bool
        
        var body: some View {
            CustomNavigationLink(destination: NormalThirdPage(isActive: $isActive)) {
                Text("두번째 페이지 컨텐츠 내용, isActive: \(isActive ? "true" : "false")")
                    .navigationTitle("두번째 페이지")
            }
        }
    }
    
    struct TempFirstPage: View {
        @State var isActive = false
        
        var body: some View {
            NavigationView {
                CustomNavigationLink(destination: TempSecondPage(isActive: $isActive), isActive: $isActive) {
                    Text("첫번째 페이지 isActive: \(isActive ? "true" : "false")")
                }
            }
        }
    }
    
    static var previews: some View {
        TempFirstPage()
    }
}
