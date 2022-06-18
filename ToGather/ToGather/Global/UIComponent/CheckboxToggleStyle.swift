//
//  CheckboxToggleStyle.swift
//  ToGather
//
//  Created by DaeSeong on 2022/06/17.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
  @Environment(\.isEnabled) var isEnabled
    
  func makeBody(configuration: Configuration) -> some View {
    Button(action: {
      configuration.isOn.toggle() // toggle the state binding
    }, label: {
      HStack {
          configuration.label
          Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
          .imageScale(.large)
      }
    })
    .buttonStyle(PlainButtonStyle()) // remove any implicit styling from the button
    .disabled(!isEnabled)
  }

}
