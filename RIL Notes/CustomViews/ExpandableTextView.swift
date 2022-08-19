//
//  ExpandableTextView.swift
//  RIL Notes
//
//  Created by Srikanth Gimka on 17/08/22.
//

import SwiftUI


struct ExpandableTextView: View {
    @State var placeholder: String = ""
    @State var font: UIFont = UIFont()
    @Binding var text: String
    let minHeight: CGFloat = 50
    @State private var height: CGFloat?
    @State var onCommit: (()-> Void)?
    @State var showPlaceHolder = false

    var body: some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
               VStack {
                    Text(placeholder)
                       .foregroundColor(Color.gray)
                        .padding(.top, 10)
                        .padding(.leading, 6)
                        .opacity(showPlaceHolder ? 0.85 : 0)
                    Spacer()
                }
            }
            TextView(text: $text, textDidChange: self.textDidChange) { // Configuring the text field
                $0.font = font
                $0.isScrollEnabled = true
                $0.isEditable = true
                $0.isUserInteractionEnabled = true
                $0.backgroundColor = UIColor(white: 0.0, alpha: 0.00)
                $0.textColor = UIColor.label
            }
            onCommit: { // Detecting the commit
                self.onCommit?()
            }
            .frame(height: height ?? minHeight)
            .opacity(showPlaceHolder ? 0.85 : 1)

        }
    }

    private func textDidChange(_ textView: UITextView) {
        showPlaceHolder = textView.text.isEmpty
        self.height = max(textView.contentSize.height, minHeight)
    }
}


struct TextView: UIViewRepresentable {
    @Binding var text: String
    let textDidChange: (UITextView) -> Void

    var configurate: (UITextView) -> ()
    var onCommit: ()->()

    func makeCoordinator() -> Coordinator {
        return Coordinator(self, text: $text, textDidChange: textDidChange)
    }

    func makeUIView(context: Context) -> UITextView {
        let myTextView = UITextView()
        configurate(myTextView) // Forwarding the configuring step
        myTextView.isEditable = true
        myTextView.delegate = context.coordinator
        return myTextView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        DispatchQueue.main.async {
            self.textDidChange(uiView)
        }
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        @Binding var text: String
        let textDidChange: (UITextView) -> Void

        init(_ uiTextView: TextView, text: Binding<String>, textDidChange: @escaping (UITextView) -> Void) {
            self.parent = uiTextView
            self._text = text
            self.textDidChange = textDidChange
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if (text == "\n") {
                textView.resignFirstResponder()
                parent.onCommit() // Execute the passed `onCommit` method here
            }
            return true
        }
        

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text // Update the actual variable
            self.text = textView.text
            self.textDidChange(textView)
        }

    }

}
