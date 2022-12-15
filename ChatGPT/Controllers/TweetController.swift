//
//  TweetController.swift
//  ChatGPT
//
//  Created by Jared Davidson on 12/7/22.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import UIKit

class TweetController {
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    func uploadTweet(tweet: Tweet, image: UIImage?, completion: @escaping (Error?) -> Void) {
        if let image = image {
            // Generate a unique ID for the image
            let imageID = UUID().uuidString
            let imageRef = storage.reference().child("images/\(imageID)")
            
            // Upload the image to Firebase Storage
            imageRef.putData(image.jpegData(compressionQuality: 0.6)!, metadata: nil) { metadata, error in
                if let error = error {
                    completion(error)
                    return
                }
                
                // Get the download URL for the image
                imageRef.downloadURL { url, error in
                    if let error = error {
                        completion(error)
                        return
                    }
                    
                    guard let url = url else {
                        let error = NSError(
                            domain: "TweetController",
                            code: -1,
                            userInfo: [
                                NSLocalizedDescriptionKey: "Failed to get download URL for image"
                            ]
                        )
                        completion(error)
                        return
                    }
                    
                    // Set the image URL on the tweet
                    var tweetWithImage = tweet
                    tweetWithImage.image = url.absoluteString
                    
                    self.db.collection("tweets").document(tweetWithImage.id).setData(tweetWithImage.toDictionary())
                }
            }
        } else {
            self.db.collection("tweets").document(tweet.id).setData(tweet.toDictionary())
        }
    }
}
