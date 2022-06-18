//
//  DisplayModeView.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/18.
//

import SwiftUI

struct DisplayModeView: View {
    @AppStorage("displayMode") var nowDisplayMode = DisplayMode.system
    let displayMode : DisplayMode
    let title : String
    var body: some View {
        
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(self.nowDisplayMode == displayMode ? .basicBlack : .black02)
            Spacer()
            Image(systemName:  self.nowDisplayMode == displayMode ? "checkmark.circle.fill" : "circle")
                .imageScale(.large)
                .onTapGesture {
                    nowDisplayMode = displayMode
                    nowDisplayMode.setAppDisplayMode()
                    
                }
        }
        .foregroundColor(self.nowDisplayMode == displayMode ? .pointColor : .black03)    }
}

struct DisplayModeView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayModeView(displayMode: .system, title: "시스템 설정")
    }
}
