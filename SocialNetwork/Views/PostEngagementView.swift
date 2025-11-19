//
//  PostEngagementView.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 17/11/2025.
//

import UIKit

class PostEngagementView: UIView {

    var isLiked = false
    var isCommentTapped = false

    private let likeStack = UIStackView()
    private let commentStack = UIStackView()
    private let shareStack = UIStackView()

    private let likeButton = UIButton(type: .system)
    private let commentButton = UIButton(type: .system)
    private let shareButton = UIButton(type: .system)

    private let likeLabel = UILabel()
    private let commentLabel = UILabel()
    private let shareLabel = UILabel()

    var onLikeTapped: (() -> Void)?
    var onCommentTapped: (() -> Void)?
    var onShareTapped: (() -> Void)?
    
    var showReplyIcon: Bool = false {
        didSet {
            updateCommentIcon()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    private func updateCommentIcon() {
        let icon = showReplyIcon ? ImageManager.replyIcon : ImageManager.commentIcon
        commentButton.setImage(icon, for: .normal)
    }



    private func setup() {

        likeButton.setImage(ImageManager.likeIcon, for: .normal)
        updateCommentIcon()
        shareButton.setImage(ImageManager.shareIcon, for: .normal)

        [likeButton, commentButton, shareButton].forEach {
            $0.tintColor = .systemGray
            $0.imageView?.contentMode = .scaleAspectFit
        }

        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)

        [likeLabel, commentLabel, shareLabel].forEach {
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .darkGray
            $0.text = "\(0)"
        }

        setupMiniStack(stack: likeStack, button: likeButton, label: likeLabel)
        setupMiniStack(stack: commentStack, button: commentButton, label: commentLabel)
        setupMiniStack(stack: shareStack, button: shareButton, label: shareLabel)

        let mainStack = UIStackView(arrangedSubviews: [likeStack, commentStack, shareStack])
        mainStack.axis = .horizontal
        mainStack.alignment = .center
        mainStack.distribution = .equalSpacing

        addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }


    private func setupMiniStack(stack: UIStackView, button: UIButton, label: UILabel) {
        stack.axis = .horizontal
        stack.spacing = 4
        stack.addArrangedSubview(button)
        stack.addArrangedSubview(label) 

        button.widthAnchor.constraint(equalToConstant: 25).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }



    func configure(likes: Int, comments: Int, shares: Int) {
        likeLabel.text = "\(likes)"
        commentLabel.text = "\(comments)"
        shareLabel.text = "\(shares)"
    }


    @objc private func didTapLike() {
        isLiked ? likeButton.setImage(ImageManager.likeIcon, for: .normal):
            likeButton.setImage(ImageManager.likeFilledIcon, for: .normal)
        isLiked.toggle()
        onLikeTapped?()
    }

    @objc private func didTapComment() {
        if !showReplyIcon {
            isCommentTapped ? commentButton.setImage(ImageManager.commentIcon, for: .normal):
                            commentButton.setImage(ImageManager.commentFilledIcon, for: .normal)
        }
        
        isCommentTapped.toggle()
        onCommentTapped?()
    }

    @objc private func didTapShare() {
        onShareTapped?()
    }
}
