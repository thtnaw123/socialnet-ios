//
//  CommentTableViewCell.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 19/11/2025.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    static let identifier = "commentTableViewCellIdentifier"

    @IBOutlet weak var commentEngagementView: PostEngagementView!
    
    @IBOutlet weak var userNameLabel: UILabel!
   
    @IBOutlet weak var commentBodyLabel: UILabel!
    
    var targetComments:CommentsModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func hydrateComments() {
        userNameLabel.text = targetComments?.name
        commentBodyLabel.text = targetComments?.body
    }
    
}
