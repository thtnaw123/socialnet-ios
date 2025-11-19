//
//  ViewController+UITableDelgateSource.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 14/11/2025.
//

import UIKit

extension PostListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
