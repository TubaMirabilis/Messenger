import SwiftUI

struct ChatRow: View {
    let type: MessageType
    var isSender: Bool {
        return type == .sent
    }
    let text: String
    init(text: String, type: MessageType) {
        self.text = text
        self.type = type
    }
    var body: some View {
        HStack {
            if isSender {
                Spacer()
            }
            if !isSender {
                VStack {
                    Spacer()
                    Circle()
                        .frame(width: 45, height: 45)
                        .foregroundColor(Color.pink)
                }
            }
            HStack {
                Text(text)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(isSender ? Color.white : Color(.label))
                    .padding()
                }
            .background(isSender ? Color.purple : Color(.systemGray4))
            .padding(isSender ? .leading : .trailing,
                     isSender ? UIScreen.main.bounds.width*0.28 : UIScreen.main.bounds.width*0.2)
            .cornerRadius(7)
            if !isSender {
                Spacer()
            }
        }
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(text: "Test", type: .received)
            .preferredColorScheme(.dark)
    }
}
