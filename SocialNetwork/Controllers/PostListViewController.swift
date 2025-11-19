//
//  ViewController.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 14/11/2025.
//

import UIKit
import Combine

class PostListViewController: UIViewController {
    
    @IBOutlet weak var headerView: NewsFeedHeaderView!
    
    @IBOutlet weak var postTableView: UITableView!
    
    @IBOutlet weak var errorMessage: UILabel!
    
//    let postServices = APIServices()
//    lazy var postViewModel = PostViewModel(postServices: postServices)
//    lazy var userViewModel = UserViewModel(postServices: postServices)

    let feedsViewModel = FeedsViewModel(apiService: APIServices())
    private var cancellables = Set<AnyCancellable>()

    let spinner = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.delgate = self
        setUpTableView()
        bindViewModel()
//        postViewModel.fetchPosts()
        feedsViewModel.fetchPostFeed()
        setUpLoader()
    }
    
    func setUpLoader(){
        spinner.center = view.center
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
    }
    func setUpTableView(){
        postTableView.dataSource = self
        postTableView.delegate = self
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        postTableView.register(nib, forCellReuseIdentifier: PostTableViewCell.identifier)
        postTableView.rowHeight=200
        postTableView.separatorStyle = .none
    }
    
    func bindViewModel(){
        feedsViewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] errorMessage in
                    if let errorMsg = errorMessage{
                        self?.errorMessage.text = errorMsg
                        self?.errorMessage.isHidden = false
                        self?.postTableView.isHidden = true
                    }else{
                        self?.errorMessage.isHidden = true
                    }
            })
            .store(in: &cancellables)
        
        feedsViewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] value in
                    if value {
                        self?.startLoading()
                    }else{
                        self?.stopLoading()
                    }
                
            }
            .store(in: &cancellables)
        
        feedsViewModel.$feeds
            .receive(on: DispatchQueue.main)
            .sink{[weak self]   _ in
//                if let count = self?.feedsViewModel.feeds.count{
//                    self?.headerView.numberOfNotifications=count
//                }
                    self?.postTableView.reloadData()
                
            }
            .store(in: &cancellables)
        
    }
    
    
    func startLoading() {
        spinner.startAnimating()
        postTableView.backgroundView = spinner

    }
    
    func stopLoading() {
        spinner.stopAnimating()
        postTableView.backgroundView = nil
    }

}

