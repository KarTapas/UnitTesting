//
//  LoginView.swift
//  LoginPageUnitTesting
//
//  Created by Tapas Kumar Kar on 19/09/23.
//

import SwiftUI

struct LoginView: View {
    @State var username = ""
    @State var password = ""
    @State var loginsuccess = false
    @State var isPasswordHidden = true
    
    @ObservedObject var viewModel = LoginViewModel()
    
    internal var isLoginButtonDisabled: Bool {
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
                    loginAction()
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
    func loginAction() {
        viewModel.getToken(username: username, password: password) { success in
            if success {
                loginsuccess = true
            }
            
        }
        
        struct LoginView_Previews: PreviewProvider {
            static var previews: some View {
                LoginView()
            }
        }
        
        
    }
}
