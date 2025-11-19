//
//  CommentsModel.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 19/11/2025.
//

import Foundation


struct CommentsModel:Decodable{
    var postId:Int
    var id:Int
    var name:String
    var email:String
    var body:String
}

