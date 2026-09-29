//
//  ProfileViewController.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 18/11/2025.
//

import UIKit
import Combine

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var websiteLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var streetLabel: UILabel!
    
    @IBOutlet weak var errorMessage: UILabel!
        
    var targetUserId:Int = 1
    let spinner = UIActivityIndicatorView(style: .medium)
    
    private var cancellables = Set<AnyCancellable>()
    let userViewModel = UserViewModel(postServices: APIServices())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLoader()
        bindUserViewModel()
        userViewModel.fetchUser(userId: targetUserId)
    }
    
    func setUpLoader(){
        spinner.center = view.center
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
    }
    
    func bindUserViewModel(){
        userViewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink {[weak self] value in
                if value {
                    self?.startLoading()
                }else{
                    self?.stopLoading()
                }
            }
            .store(in: &cancellables)
        
        userViewModel.$user
            .compactMap{$0}
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.hydrateUserProfile(user:value)
            }
            .store(in: &cancellables)
        
        userViewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] value in
                self?.errorMessage.text = value
            })
            .store(in: &cancellables)
                
    }
    
    func hydrateUserProfile(user:UserModel){
        self.userNameLabel.text = user.name
        self.cityLabel.text = user.address.city
        self.companyNameLabel.text = user.company.name
        self.streetLabel.text = user.address.street
        self.websiteLabel.text = user.website
    }
    
    func startLoading() {
        spinner.startAnimating()
    }
    
    func stopLoading() {
        spinner.stopAnimating()
    }

}
