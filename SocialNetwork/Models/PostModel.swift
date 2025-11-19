//
//  PostModel.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 17/11/2025.
//

import Foundation


struct PostModel:Codable{
    let userId:Int
    let id:Int
    let title:String
    let body:String
}


struct FeedItem {
    let post: PostModel
    let user: UserModel
}


