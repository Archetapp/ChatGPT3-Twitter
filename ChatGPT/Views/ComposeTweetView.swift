//
//  ComposeTweetView.swift
//  ChatGPT
//
//  Created by Jared Davidson on 12/7/22.
//

import Foundation
import SwiftUI
import UIKit

struct ComposeTweetView: View {
    @State private var content = ""
    @State private var image: UIImage?
    @State private var isImagePickerShown = false

    var body: some View {
        VStack {
            TextEditor(text: $content)
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 20)

            Image(uiImage: image ?? UIImage())
                .resizable()
                .scaledToFit()

            Button(action: {
                self.isImagePickerShown = true
            }) {
                Image(systemName: "photo")
            }

            Button(action: {
                let tweet = Tweet(id: UUID().uuidString, user: "username", content: self.content, image: "", date: Date().ISO8601Format())
                let tweetController = TweetController()
                tweetController.uploadTweet(tweet: tweet, image: image) { error in
                    if let error = error {
                        print("Error uploading tweet: \(error)")
                    } else {
                        print("Tweet uploaded successfully")
                    }
                }
            }) {
                Text("Compose Tweet")
            }
        }
        .sheet(isPresented: $isImagePickerShown) {
            ImagePicker(image: self.$image)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
