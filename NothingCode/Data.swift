//
//  Data.swift
//  NothingCode
//
//  Created by Sample on 2021/7/30.
//

import SwiftUI

import SwiftUI

struct Post: Codable, Identifiable {
    var id = UUID()
    var title: String
    var body: String
}

class Api {
    func getPosts(completion: @escaping ([Post]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                DispatchQueue.main.sync {
                    completion(posts)
                }
            } catch {
                
            }
            
        }
        .resume()
    }
}
