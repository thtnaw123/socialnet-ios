//
//  CommentsViewController+TableView.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 19/11/2025.
//

import Foundation
import UIKit

extension CommentsViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CommentsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        commentsViewModel.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier ,for:indexPath) as?
                CommentTableViewCell else{
            return UITableViewCell()
        }
        cell.commentEngagementView.showReplyIcon = true
        cell.targetComments = commentsViewModel.comments[indexPath.row]
        cell.hydrateComments()
        return cell
    }
    
}
