//
//  FAQScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 21. 8. 2024..
//

import SwiftUI

struct FAQScreenView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.lightgray).ignoresSafeArea()
                    
                    ScrollViewReader { scrollView in
                        VStack {
                            VStack {
                                Spacer()
                                HStack {
                                    Button {
                                        dismiss()
                                    } label: {
                                        Image(systemName: "chevron.left")
                                            .foregroundStyle(.white)
                                            .padding(.horizontal)
                                    }
                                    .frame(width: 44)

                                    Spacer()
                                    
                                    Text("FAQ")
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                        .padding(.vertical)
                                    
                                    Spacer()
                                    
                                    Button(action: {}) {
                                        Image(systemName: "chevron.left")
                                            .foregroundStyle(.clear)
                                            .padding(.horizontal)
                                    }
                                    .frame(width: 44) // For centering the "FAQ"
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: 120)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                            .ignoresSafeArea(edges: .top)
                        
                        ScrollView {
                            ForEach(FAQList().faqs.indices, id: \.self) { index in
                                DisclosureGroup(FAQList().faqs[index].question) {
                                    Text(FAQList().faqs[index].answer)
                                        .padding(.vertical)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                                .padding()
                                .onTapGesture {
                                    withAnimation {
                                        scrollView.scrollTo(index, anchor: .center)
                                    }
                                }
                                .id(index)
                                Spacer()
                            }
                        }
                    }
                    Spacer()
                }
                
            }
        }
    }
}

#Preview {
    FAQScreenView()
}
