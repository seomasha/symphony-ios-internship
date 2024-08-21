//
//  Card.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 21. 8. 2024..
//

import SwiftUI

struct Card: View {
    
    var title: String
    var rows: [CardRowModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            
            VStack {
                ForEach(rows, id: \.id) {row in
                    CardRow(icon: row.icon,
                            title: row.title,
                            subtitle: row.subtitle,
                            warning: row.warning,
                            action: row.action)
                }
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
            .shadow(radius: 1)
            .padding()
            
        }
    }
}

#Preview {
    Card(title: "Account", rows: CardViewModel().profileRows)
}
