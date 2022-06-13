//
//  TitleView.swift
//  ToGather
//
//  Created by yudonlee on 2022/06/08.
//

import SwiftUI

struct MainTitleView: View {
    var body: some View {
        HStack(spacing: 6) {
            Text("친구와 함께")
                .foregroundColor(.pointColor)
                .fontWeight(.bold)
            Text("저축하시겠어요?")
                .foregroundColor(.basicBlack)
                .fontWeight(.bold)
        }
        .font(.system(size: 24))
    }
}

struct SubTitleView: View {
    var body: some View {
        HStack(spacing: 4) {
            Text("친구와")
                .foregroundColor(.basicBlack.opacity(0.6))
                .fontWeight(.bold)
            HStack(spacing: 0) {
                Text("저축현황")
                    .foregroundColor(.pointColor)
                    .fontWeight(.bold)
                Text("을 공유할 수 있어요")
                    .foregroundColor(.basicBlack.opacity(0.6))
                    .fontWeight(.bold)
            }
        }
        .font(.system(size: 16))
    }
}

struct TitleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            MainTitleView()
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
            SubTitleView()
            .padding(EdgeInsets(top: 0, leading: 21, bottom: 0, trailing: 0))
        }
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity,
               minHeight: 0, idealHeight: 58,
               maxHeight: 58, alignment: .topLeading)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
