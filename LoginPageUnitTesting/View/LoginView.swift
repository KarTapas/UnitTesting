

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isPasswordHidden = true

    @ObservedObject var viewModel = LoginViewModel()

    private var isLoginButtonDisabled: Bool {
        return username.isEmpty || password.isEmpty
    }

    var body: some View {
        ZStack {
            Image("Unknown")
                           .resizable()
                           .edgesIgnoringSafeArea(.all)
                           .opacity(1.0)

            VStack {
                Text("Sign In")
                    .foregroundColor(.white)
                    .font(.system(size: 40, design: .rounded))
                    .offset(y: -220)

                TextField("Username", text: $username)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .offset(y: -180)
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                    .offset(y: -180)

                HStack {
                    if isPasswordHidden {
                        SecureField("Password", text: $password)
                            .accentColor(.white)
                    } else {
                        TextField("Password", text: $password)
                            .accentColor(.white)
                    }

                    Button(action: {
                        isPasswordHidden.toggle()
                    }) {
                        Image(systemName: isPasswordHidden ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.white)
                    }

                }
                .foregroundColor(.white)
                .textFieldStyle(.plain)
                .offset(y: -140)

                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                    .offset(y: -140)

                Button(action: {
                    viewModel.login(username: username, password: password)
                }) {
                    Text("Login")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.white.opacity(0.5))
                        )
                        .foregroundColor(.red)
                }
                .offset(y: -100)
             .disabled(isLoginButtonDisabled)

                Button(action: {
                    // Handle Forgot Password action
                }) {
                    Text("Forgot Password?")
                        .bold()
                        .foregroundColor(.white)
                }
                .offset(y: -70)

                if viewModel.isLoggedIn {
                    Text("Welcome")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
            .frame(width: 350)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

