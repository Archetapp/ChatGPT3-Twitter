//
//  ProfileView.swift
//  ChatGPT
//
//  Created by Jared Davidson on 12/7/22.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @StateObject var profileController = ProfileController()
    var body: some View {
        ScrollView {
            VStack(spacing: 20.0) {
                HStack {
                    Image("profile")
                        .resizable()
                        .frame(width: 100.0, height: 100.0)
                        .clipShape(Circle())
                    VStack(alignment: .leading, spacing: 10.0) {
                        Text("username")
                            .font(.title)
                        Text("@username")
                            .font(.subheadline)
                    }
                    Spacer()
                    Button(action: {
                        // Show edit profile view
                    }) {
                        Text("Edit Profile")
                            .font(.callout)
                            .foregroundColor(.blue)
                    }
                }
                HStack(spacing: 20.0) {
                    VStack(alignment: .center) {
                        Text("Tweets")
                            .font(.title)
                        Text("0")
                            .font(.headline)
                    }
                    VStack(alignment: .center) {
                        Text("Following")
                            .font(.title)
                        Text("0")
                            .font(.headline)
                    }
                    VStack(alignment: .center) {
                        Text("Followers")
                            .font(.title)
                        Text("0")
                            .font(.headline)
                    }
                }
                ForEach(profileController.tweets, id: \.id) { tweet in
                    TweetCardView(tweet: tweet)
                }
            }
        }
        .navigationBarTitle("Profile")
        .onAppear() {
            profileController.fetchTweets()
        }
    }
}
