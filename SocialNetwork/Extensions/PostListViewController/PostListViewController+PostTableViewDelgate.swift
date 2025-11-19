//
//  ViewController+PostTableViewDelgate.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 18/11/2025.
//

import Foundation
import UIKit

extension PostListViewController:PostTableViewCellDelgate{
    func passToProfile(userId: Int) {
        if let profileVC = routeToPage(identifier: "ProfileViewController") as? ProfileViewController{
            profileVC.targetUserId = userId
            navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    func navigateToComment(postId:Int){
        if let commentsVC = routeToPage(identifier: "CommentListViewController") as? CommentsViewController{
            commentsVC.targetPostId = postId
//            navigationController?.pushViewController(commentsVC, animated: true)
//            commentsVC.modalPresentationStyle = .formSheet
            present(commentsVC, animated: true)
        }
    }
    
  
    
}
