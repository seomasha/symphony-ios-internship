//
//  FlightOptionPicker.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 28. 8. 2024..
//

import SwiftUI

struct FlightOptionPicker: View {
    @Binding var selectedOption: String
    let options: [String]
    
    @Namespace private var animationNamespace
    
    var body: some View {
        HStack {
            ForEach(options, id: \.self) { option in
                Spacer()
                
                Text(option)
                    .foregroundStyle(selectedOption == option ? Color.white : Color.gray)
                    .fontWeight(.light)
                    .font(.caption)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(
                        Capsule()
                            .fill(selectedOption == option ? Color(.lightblue) : Color.white)
                            .matchedGeometryEffect(id: option, in: animationNamespace)
                    )
                    .scaleEffect(selectedOption == option ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0), value: selectedOption)
                    .onTapGesture {
                        withAnimation {
                            selectedOption = option
                        }
                    }
                
                Spacer()
            }
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(Capsule())
        .shadow(radius: 3)
    }
}

#Preview {
    FlightOptionPicker(selectedOption: .constant("One way"),
                       options: ["One way", "Round", "Multicity"])
}
