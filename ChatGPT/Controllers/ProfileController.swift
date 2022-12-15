//
//  ProfileController.swift
//  ChatGPT
//
//  Created by Jared Davidson on 12/7/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Firebase


class ProfileController: ObservableObject {
    let db = Firestore.firestore()
    @Published var tweets = [Tweet]()

    func fetchTweets() {
        // Get the "tweets" collection from Firestore
        let collection = self.db.collection("tweets")

        // Get all the documents in the collection
        collection.getDocuments(completion: { documents, error in
            guard let documents = documents else { return }
            let tweets = documents.documents.map { document -> Tweet in
                let data = document.data()
                let tweet = Tweet(from: data)
                return tweet
            }
            self.tweets = tweets
        })
    }
}
