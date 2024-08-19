//
//  TextFieldView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 13. 8. 2024..
//

import SwiftUI

struct TextFieldView: View {
    let placeholder: String
    @Binding var text: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        TextField(placeholder, text: $text)
            .focused($isFocused)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .textFieldStyle(.roundedBorder)
    }
}

struct TextFieldView_Preview: PreviewProvider {
    static var previews: some View {
        @State var sampleText = "Sample"
        @FocusState var isFocused: Bool
        
        TextFieldView(placeholder: "Enter your text", text: $sampleText, isFocused: _isFocused)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
