//
//  UserAuthView.swift
//  ChatGPT
//
//  Created by Jared Davidson on 12/7/22.
//

import Foundation
import SwiftUI

struct UserAuthView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var error: String = ""
    @State private var showingSignUpView = false
    
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .background(Color.white)
                .cornerRadius(5.0)
                .shadow(radius: 5.0)
            SecureField("Password", text: $password)
                .padding()
                .background(Color.white)
                .cornerRadius(5.0)
                .shadow(radius: 5.0)
            Button(action: login) {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
            }
            .cornerRadius(5.0)
            .shadow(radius: 5.0)
            Button(action: { self.showingSignUpView.toggle() }) {
                Text("Sign Up")
            }
            Text(error)
        }
        .padding()
        .background(Color.white)
        .sheet(isPresented: $showingSignUpView) {
            UserSignUpView()
        }
    }
    
    func login() {
        UserAuthController.shared.login(email: email, password: password) { (result) in
            switch result {
            case .success(let user):
                // User was successfully authenticated
                print("User authenticated: \(user.email)")
            case .failure(let error):
                // There was an error authenticating the user
                print("Error authenticating user: \(error)")
            }
        }
    }
}
