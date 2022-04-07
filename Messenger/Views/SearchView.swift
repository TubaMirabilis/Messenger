import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var model: AppStateModel
    @State var text: String = ""
    @State var usernames: [String] = []
    let completion: ((String) -> Void)
    init(completion: @escaping ((String) -> Void)) {
        self.completion = completion
    }
    var body: some View {
        VStack {
            HStack {
                TextField("Username...", text: $text)
                    .modifier(CustomField())
                Button(action: {
                    guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                        return
                    }
                    model.searchUsers(queryText: text) { usernames in
                        self.usernames = usernames
                    }
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 36))
                        .modifier(CustomButton())
                })
            }
            List {
                ForEach(usernames, id: \.self) { name in
                    HStack {
                        Circle()
                            .frame(width: 45, height: 45)
                            .foregroundColor(Color.pink)
                        Text(name)
                            .bold()
                        Spacer()
                    }
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                        completion(name)
                    }
                }
            }
            Spacer()
        }
        .navigationTitle("Search")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView() { _ in }
            .preferredColorScheme(.dark)
    }
}
