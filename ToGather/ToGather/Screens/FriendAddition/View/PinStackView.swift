import SwiftUI
import Introspect

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

let column = [
    GridItem(.fixed(46), alignment: .leading),
    GridItem(.fixed(46)),
    GridItem(.fixed(46)),
    GridItem(.fixed(46)),
    GridItem(.fixed(46)),
    GridItem(.fixed(46))
]

struct PinStackView: View {
    let maxDigits = 6
    @Binding var attempts: Int
    @Binding var pin: String
    @Binding var wrongFriendInput: Bool
    var isKeyboardHide: FocusState<Bool>.Binding
    
    // String is the pin code, bool is completed or not
    var handler: ((String, Bool) -> Void)
    var body: some View {
        ZStack {
            backgroundField
            LazyVGrid(
                columns: column, alignment: .leading, spacing: 6) {
                    ForEach( 0..<maxDigits ) { digit in
                        if self.getPinNumber(digit) != "-1" {
                            Text("\(self.getPinNumber(digit))")
                                .frame(width: 46, height: 46)
                                .foregroundColor(.pointColor)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder(.blue, lineWidth: 1.5)
                                        .frame(width: 46, height: 46)
                                        .foregroundColor(.pointColor)

                                )
                        } else {
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 46, height: 46)
                                .foregroundColor(.basicBlack.opacity(0.1))

                        }
                    }
                }
                .modifier(Shake(animatableData: CGFloat(attempts)))
        }.onTapGesture {
            isKeyboardHide.wrappedValue.toggle()
        }
    }
    
    private var backgroundField: some View {
        let boundPin = Binding<String>(
            get: { self.pin },
            set: { newValue in
            self.pin = newValue
            
            if newValue.count == 1 {
                wrongFriendInput = false
            }
            if newValue.count == self.maxDigits {
                if !isPinExist(inputString: newValue) {
                    self.shake()
                }
                self.isKeyboardHide.wrappedValue.toggle()
            }
                self.handler(newValue, newValue.count == self.maxDigits)
            
            })
        return TextField("", text: boundPin).introspectTextField { textField in
            textField.isHidden = true
        } .focused(isKeyboardHide)
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    isKeyboardHide.wrappedValue = true
                }
                
            })
    }
}

extension PinStackView {
   
    func getPinNumber(_ index: Int) -> String {
        
        let pin = Array(self.pin)
        
        if pin.indices.contains(index), !String(pin[index]).isEmpty { return String(pin[index]) }
        return "-1"
    }
    private func closeKeyboard() {
        UIApplication.shared.endEditing() // Closing keyboard does not exist for swiftui yet
    }
    private func shake() {
        withAnimation(.default) {
            self.attempts += 1
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
