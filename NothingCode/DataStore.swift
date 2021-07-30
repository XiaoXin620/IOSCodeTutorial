//
//  DataStore.swift
//  NothingCode
//
//  Created by Sample on 2021/7/30.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        Api().getPosts{ (posts) in
            self.posts = posts
        }
    }
}
