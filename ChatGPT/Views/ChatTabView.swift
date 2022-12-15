//
//  ChatTabView.swift
//  ChatGPT
//
//  Created by Jared Davidson on 12/7/22.
//

import Foundation
import SwiftUI

struct ChatTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}
