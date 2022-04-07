import SwiftUI

struct SignInView: View {
    @State var username: String = ""
    @State var password: String = ""
    @EnvironmentObject var model: AppStateModel
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("Messenger")
                    .bold()
                    .font(.system(size: 34))
                VStack {
                    TextField("Username...", text: $username)
                        .modifier(CustomField())
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .disableAutocorrection(true)
                    SecureField("Password...", text: $password)
                        .modifier(CustomField())
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .disableAutocorrection(true)
                    Button(action: {
                        self.signIn()
                    }, label: {
                        Text("Sign in")
                            .foregroundColor(Color.white)
                            .frame(width: 220, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.purple)
                            .cornerRadius(6)
                    })
                }
                .padding()
                Spacer()
                NavigationLink("Sign up to unleash the power of Messenger",
                               destination: SignUpView())
            }
        }
    }
    func signIn() {
        guard !username.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else {
            return
        }
        model.signIn(username: username, password: password)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .preferredColorScheme(.dark)
    }
}
