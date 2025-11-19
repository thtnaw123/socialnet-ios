//
//  ViewController+NewsFeedHeaderDelgate.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 18/11/2025.
//

import Foundation
import UIKit

extension PostListViewController:NewsFeedHeaderDelgate{
    func routeToProfile() {
        if let profileViewController = routeToPage(identifier: "ProfileViewController") as? ProfileViewController {
            navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
    
    func routeToNotifications() {
        
    }
    
    func routeToPage(identifier:String) -> UIViewController? {
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: identifier){
            return destinationVC
        }
        return nil
    }
    
}
