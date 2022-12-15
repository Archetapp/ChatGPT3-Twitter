//
//  UserSignUpView.swift
//  ChatGPT
//
//  Created by Jared Davidson on 12/7/22.
//

import Foundation
import SwiftUI

struct UserSignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var error: String = ""

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
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color.white)
                .cornerRadius(5.0)
                .shadow(radius: 5.0)
            Button(action: signUp) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
            }
            .cornerRadius(5.0)
            .shadow(radius: 5.0)
            Text(error)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }

    func signUp() {
        UserAuthController.shared.signUp(email: email, password: password) { (result) in
            switch result {
            case .success(let user):
                // User was successfully signed up
                print("User signed up: \(user.email)")
            case .failure(let error):
                // There was an error signing up
                print(error)
            }
        }
    }
}

