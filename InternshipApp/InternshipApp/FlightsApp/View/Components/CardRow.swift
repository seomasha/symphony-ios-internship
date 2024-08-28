import SwiftUI

struct CardRow: View {
    @ObservedObject var viewModel: UserViewModel
    var icon: String
    var title: String
    var subtitle: String
    var warning: String = ""
    var action: (() -> Void)?
    var destination: AnyView?

    @State private var isPressed = false

    var body: some View {
        if title == "Face ID" {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .padding()
                    .background(.bar)
                    .foregroundColor(.blue)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 15) {
                    Text(title)
                        .font(.system(size: 14))
                        .fontWeight(.semibold)

                    Text(subtitle)
                        .font(.system(size: 12))
                        .fontWeight(.light)
                }
                .padding(.horizontal)

                Spacer()

                Toggle(isOn: $viewModel.faceIDEnabled) {
                    Text("")
                }
                .onChange(of: viewModel.faceIDEnabled) { _, _ in
                    Task {
                        do {
                            try await viewModel.saveFaceIDPreference()
                        } catch {
                            print("Error saving Face ID preference: \(error)")
                        }
                    }
                }
            }
            .padding()
        } else {
            if let destination = destination {
                NavigationLink(destination: destination) {
                    rowContent
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                Button {
                    withAnimation {
                        isPressed = true
                        action?()

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation {
                                isPressed = false
                            }
                        }
                    }
                } label: {
                    rowContent
                        .background(isPressed ? Color.blue.opacity(0.1) : Color.clear)
                        .cornerRadius(10)
                        .scaleEffect(isPressed ? 0.95 : 1.0)
                        .animation(.easeInOut(duration: 0.2), value: isPressed)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }

    private var rowContent: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .padding()
                .background(.bar)
                .foregroundColor(.blue)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 15) {
                Text(title)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)

                Text(subtitle)
                    .font(.system(size: 12))
                    .fontWeight(.light)
            }
            .padding(.horizontal)

            Spacer()

            Image(systemName: warning)
                .foregroundStyle(.red)

            Image(systemName: "greaterthan")
                .foregroundStyle(.gray)
        }
        .padding()
    }
}

#Preview {
    CardRow(viewModel: UserViewModel(), 
            icon: "person",
            title: "My account",
            subtitle: "Make changes to your account",
            destination: AnyView(EmptyView()))
}
