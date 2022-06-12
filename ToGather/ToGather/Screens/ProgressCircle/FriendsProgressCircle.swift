//
//  FriendsProgressCircle.swift
//  ToGather
//
//  Created by hyo on 2022/06/12.
//

import SwiftUI

let friendColor1 = RGBColorInProgressCircle(red: 0.91, green: 0.43, blue: 0.54)
let friendColor2 = RGBColorInProgressCircle(red: 0.74, green: 0.58, blue: 0.91)
let friendColor3 = RGBColorInProgressCircle(red: 0.44, green: 0.66, blue: 0.97)

struct FriendsProgressCircle: View {
    var color: RGBColorInProgressCircle
    
    var body: some View {
        ZStack {
            ProgressCircle(color: color)
        }
    }
}

struct FriendsProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        FriendsProgressCircle(color: friendColor1)
    }
}
