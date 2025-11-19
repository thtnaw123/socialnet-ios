//
//  NewsFeedHeaderView.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 14/11/2025.
//

import UIKit

protocol NewsFeedHeaderDelgate {
    func routeToProfile()
    func routeToNotifications()
}

class NewsFeedHeaderView: UIView {
    let containerStackView = UIStackView()
    let profileButton = UIButton()
    let notificationButton = UIButton()
    var numberOfNotifications:Int = 0 {
        didSet{
            notificationButton.setTitle("\(numberOfNotifications)", for: .normal)
        }
    }
    
    var delgate:NewsFeedHeaderDelgate?
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setUpUI()
    }

    required init?(coder: NSCoder) {
            super.init(coder: coder)
            setUpUI()
    }

    func setUpProfileButton(){
        profileButton.setImage(ImageManager.profileIcon, for: .normal)
        profileButton.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
//        profileButton.layer.borderWidth = 2
//        profileButton.layer.borderColor = UIColor.lightGray.cgColor
        profileButton.translatesAutoresizingMaskIntoConstraints=false
        profileButton.contentHorizontalAlignment = .fill
        profileButton.contentVerticalAlignment = .fill
        profileButton.imageView?.contentMode = .scaleAspectFit
    }

    @objc func goToProfile(){
        delgate?.routeToProfile()
    }
    
    func setUpNotificationButton(){
        notificationButton.setImage(ImageManager.notificationIcon, for: .normal)
        notificationButton.setTitle("\(numberOfNotifications)", for: .normal)
        notificationButton.addTarget(self, action: #selector(goToNotifications), for: .touchUpInside)
//        notificationButton.layer.borderWidth = 2
//        notificationButton.layer.borderColor = UIColor.lightGray.cgColor
        notificationButton.translatesAutoresizingMaskIntoConstraints=false
        notificationButton.contentHorizontalAlignment = .fill
        notificationButton.contentVerticalAlignment = .fill
        notificationButton.imageView?.contentMode = .scaleAspectFit
    }
    
    @objc func goToNotifications(){
        delgate?.routeToNotifications()
    }
    

    
    func setUpUI(){
        containerStackView.axis = .horizontal
        containerStackView.distribution = .equalSpacing
        containerStackView.spacing = 230
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerStackView)
        
        setUpProfileButton()
        setUpNotificationButton()
        
        containerStackView.addArrangedSubview(notificationButton)
        containerStackView.addArrangedSubview(profileButton)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            profileButton.widthAnchor.constraint(equalToConstant: 30),
            profileButton.heightAnchor.constraint(equalToConstant: 15),
            notificationButton.widthAnchor.constraint(equalToConstant: 50),
            notificationButton.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
}
