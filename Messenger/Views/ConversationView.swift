import SwiftUI

struct ConversationListView: View {
    @EnvironmentObject var model: AppStateModel
    @State var otherUserName: String = ""
    @State var showChat = false
    @State var showSearch = false
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ForEach(model.conversations, id: \.self) { name in
                    NavigationLink(
                        destination: ChatView(otherUserName: name),
                        label: {
                            HStack {
                                Circle()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(Color.pink)
                                Text(name)
                                    .bold()
                                    .foregroundColor(Color(.label))
                                    .font(.system(size: 32))
                                Spacer()
                            }
                            .padding()
                        })
                }
                if !otherUserName.isEmpty {
                    NavigationLink("",
                                   destination: ChatView(otherUserName: otherUserName),
                                   isActive: $showChat)
                }
            }
            .navigationTitle("Conversations")
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Button("Sign Out") {
                        self.SignOut()
                    }
                }
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    NavigationLink(
                        destination: SearchView { name in
                            self.showSearch = false
                            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                                self.showChat = true
                                self.otherUserName = name
                            }
                        },
                        isActive: $showSearch,
                        label: {
                            Image(systemName: "magnifyingglass")
                    })
                }
            }
            .fullScreenCover(isPresented: $model.showingSignIn, content: {
                SignInView()
            })
            .onAppear {
                guard model.auth.currentUser != nil else {
                    return
                }
                model.getConversations()
            }
        }
    }
    func SignOut() {
        model.SignOut()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationListView()
            .preferredColorScheme(.dark)
    }
}
