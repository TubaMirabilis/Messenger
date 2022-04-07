import SwiftUI

struct CustomButton : ViewModifier {
    func body(content: Content) -> some View {
        return content
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .foregroundColor(Color.white)
            .background(Color.blue)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
}

struct SendButton: View {
    @Binding var text: String
    @EnvironmentObject var model: AppStateModel
    var body: some View {
        Button(action: {
            self.sendMessage()
        }, label: {
            Image(systemName: "paperplane")
                .font(.system(size: 33))
                .modifier(CustomButton())
        })
    }
    func sendMessage() {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        model.sendMessage(text: text)
        text = ""
    }
}
