//
//  UserModel.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 17/11/2025.
//

import Foundation

struct UserModel:Codable{
    let id:Int
    let name:String
    let username:String
    let email:String
    let phone:String
    let website:String
    let address:AddressModel
    let company:CompanyModel
}


struct AddressModel:Codable{
    let street:String
    let suite:String
    let city:String
    let zipcode:String
    let geo:GeoModel
}

struct GeoModel:Codable{
    let lat:String
    let lng:String
}

struct CompanyModel:Codable{
    let name:String
    let catchPhrase:String
    let bs:String
}


