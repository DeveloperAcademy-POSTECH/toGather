//
//  View+Extension.swift
//  ToGather
//
//  Created by Seungwon Choi on 2022/07/21.
//

import SwiftUI

extension View {
    
    func halfsheet<SheetView: View>(showSheet: Binding<Bool>, @ViewBuilder sheetView: @escaping ()->SheetView)->some View {
        return self
            .background(
                HalfSheetHelper(sheetView: sheetView(), showSheet: showSheet)
            )
    }
}
