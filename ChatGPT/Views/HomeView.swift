//
//  HomeView.swift
//  ChatGPT
//
//  Created by Jared Davidson on 12/7/22.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @StateObject var homeController = HomeController()
    @State var showComposeTweetView: Bool = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20.0) {
                    ForEach(homeController.tweets, id: \.id) { tweet in
                        TweetCardView(tweet: tweet)
                    }
                }
            }
            .navigationBarTitle("Home")
            .navigationBarItems(trailing:
                                    Button(action: {
                self.showComposeTweetView.toggle()
            }) {
                Image(systemName: "square.and.pencil")
            }
            )
            .background(Color(.systemGray6))
        }
        .sheet(isPresented: self.$showComposeTweetView) {
            ComposeTweetView()
        }
        .onAppear() {
            homeController.fetchTweets()
        }
    }
}

struct TweetCardView: View {
    var tweet: Tweet
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            HStack {
                Image("profile")
                    .resizable()
                    .frame(width: 50.0, height: 50.0)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 10.0) {
                    Text(tweet.user)
                        .font(.headline)
                    Text("@\(tweet.user)")
                        .font(.subheadline)
                }
            }
            Text(tweet.content)
                .font(.body)
            HStack {
                if let image = tweet.image {
                    AsyncImage(
                        url: URL(string: image)!,
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: 300)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                }
                Spacer()
            }
            HStack {
                Image(systemName: "bubble.left")
                Text("0")
                Image(systemName: "arrow.up")
                Text("0")
                Image(systemName: "arrow.down")
            }
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(8.0)
    }
}
