//
//  AddedCircleView.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/12.
//

import SwiftUI


struct AddedCircleView: View {
    let color: Color
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 80, height: 80)   
                .foregroundColor(color.opacity(0.05))
            Image(systemName: "plus")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundColor(.friendRed01)
            
        }
        .frame(width : 100, height : 100)
        
    }
}

struct AddedCircleView_Previews: PreviewProvider {
    static var previews: some View {
        AddedCircleView(color: .friendRed01)
            .previewLayout(.sizeThatFits)
        
    }
}
