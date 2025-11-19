//
//  API.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 17/11/2025.
//

import Foundation


enum Environment {
    case development
    case staging
    case production

    var baseURL :String{
        switch self {
        case .development: return "https://jsonplaceholder.typicode.com"
        case .staging: return "https://jsonplaceholder.typicode.co"
        case .production:  return "https://jsonplaceholder.typicode.co"
        }
    }
}

enum APIConfig {
    static var currentEnvironment: Environment = .development

    static var baseURL: String {
            return currentEnvironment.baseURL
        }

    static var fetchPostsEndPoints = "\(baseURL)/posts"
    static var fetchUsersURL = "\(baseURL)/users"
    static var fetchCommentsURL = "\(baseURL)/posts"
}
