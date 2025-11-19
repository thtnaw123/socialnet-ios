//
//  PostTableViewCell.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 14/11/2025.
//

import UIKit

protocol PostTableViewCellDelgate{
    func passToProfile(userId:Int)
    func navigateToComment(postId:Int)
}

class PostTableViewCell: UITableViewCell {
    
    static let identifier = "postTableViewIdentifier"

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBOutlet weak var postTimeLabel: UILabel!
    
    @IBOutlet weak var postContentLabel: UILabel!
    
//    var targetPost:PostModel?
    @IBOutlet weak var postEngagementView: PostEngagementView!
    
    var targetFeed:FeedItem?
    
    var delgate:PostTableViewCellDelgate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        initLabelGesture()
        callNavigate()
    }
    
    func callNavigate(){
        postEngagementView.onCommentTapped={[weak self] in
            if let pId = self?.targetFeed?.post.id{
                self?.delgate?.navigateToComment(postId: pId)
            }
        }
    }
    
    
    func initLabelGesture(){
        userNameLabel.isUserInteractionEnabled = true
        if userNameLabel.gestureRecognizers?.isEmpty ?? true {
            let tapG = UITapGestureRecognizer(target: self, action: #selector(onUserNameTapped))
            userNameLabel.addGestureRecognizer(tapG)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    override func layoutSubviews(){
        super.layoutSubviews()
        
        // Add spacing around the cell
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(
            top: 8, left: 16, bottom: 8, right: 16
        ))

        // Round the cell
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
    }
    
    func configurePostContent(){
        let userName = self.targetFeed?.user.name ?? "unknown user"
        userNameLabel.text = userName
        postContentLabel.text = self.targetFeed?.post.body
    }

    
    @objc func onUserNameTapped(){
        //route to profile and pass the id and show the info
        if let feed = targetFeed {
            delgate?.passToProfile(userId: feed.user.id)
        }
    }

    
}
