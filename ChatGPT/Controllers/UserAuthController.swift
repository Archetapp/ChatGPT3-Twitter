//
//  UserAuthController.swift
//  ChatGPT
//
//  Created by Jared Davidson on 12/7/22.
//

import Foundation
import FirebaseAuth

class UserAuthController: ObservableObject {
    static let shared = UserAuthController()

    private init() {}

    @Published var currentUser: User?

    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                self.currentUser = user
                completion(.success(user))
            }
        }
    }

    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                self.currentUser = user
                completion(.success(user))
            }
        }
    }
}
