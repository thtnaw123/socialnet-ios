//
//  ViewController+UITableViewCellSource.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 14/11/2025.
//

import UIKit

extension PostListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedsViewModel.feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier ,for:indexPath) as?
            PostTableViewCell else{
            return UITableViewCell()
        }
//        cell.userNameLabel.text=fruits[indexPath.row]
        cell.delgate = self
        cell.targetFeed = feedsViewModel.feeds[indexPath.row]
        cell.configurePostContent()
        return cell
    }
  
}
