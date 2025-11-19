//
//  NetworkErrorModel.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 17/11/2025.
//

import Foundation

enum NetworkErrorModel: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "invalid URL"
        case .invalidResponse:
            return "unexpected status code from server."
        case .invalidData:
            return "invalid data received from server."
        }
    }
}
