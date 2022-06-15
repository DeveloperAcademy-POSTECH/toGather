//
//  CustomProgressBar.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/14.
//

import SwiftUI

struct CustomProgressBar: View {
    @State var currentProgress: CGFloat = 0.5
    let color : Color
    var body: some View {
        
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(color.opacity(0.2))
                .frame(width: 200, height: 8)
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(color)
                .frame(width: 200*currentProgress, height: 8)
        }
    }
}

struct CustomProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressBar(currentProgress: 0.5,
                          color: .basicGreen)
            .previewLayout(.sizeThatFits)
    }
}
