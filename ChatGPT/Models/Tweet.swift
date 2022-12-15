//
//  Tweet.swift
//  ChatGPT
//
//  Created by Jared Davidson on 12/7/22.
//

import Foundation
import SwiftUI

struct Tweet: Codable {
    let id: String
    let user: String
    let content: String
    var image: String?
    var date: String
    
    init(id: String, user: String, content: String, image: String? = nil, date: String) {
        self.id = id
        self.user = user
        self.content = content
        self.image = image
        self.date = date
    }
    
    init(from dict: [String: Any]) {
        self.id = dict["id"] as? String ?? ""
        self.image = dict["image"] as? String
        self.user = dict["user"] as? String ?? ""
        self.content = dict["content"] as? String ?? ""
        self.date = dict["date"] as? String ?? ""
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        dictionary["id"] = id
        dictionary["user"] = user
        dictionary["content"] = content
        dictionary["date"] = date
        if let image = image {
            dictionary["image"] = image
        }
        return dictionary
    }
}
