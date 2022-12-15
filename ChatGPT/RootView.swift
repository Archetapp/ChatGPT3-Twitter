//
//  RootView.swift
//  ChatGPT
//
//  Created by Jared Davidson on 12/7/22.
//

import Foundation
import SwiftUI

struct RootView: View {
    @ObservedObject var userAuthController = UserAuthController.shared

    var body: some View {
        Group {
            if userAuthController.currentUser != nil {
                ChatTabView()
            } else {
                UserAuthView()
            }
        }
    }
}
