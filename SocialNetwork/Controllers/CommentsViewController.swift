//
//  CommentsViewController.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 19/11/2025.
//

import UIKit
import Combine

class CommentsViewController: UIViewController {
    
    @IBOutlet weak var commentsListTableView: UITableView!
    
    let commentsViewModel = CommentsViewModel(apiService: APIServices())
    private var cancellables = Set<AnyCancellable>()
    
    let spinner = UIActivityIndicatorView(style: .medium)
    var targetPostId:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpLoader()
        bindViewModel()
        commentsViewModel.fetchComments(postId: targetPostId)
    }
    
    func bindViewModel(){
        commentsViewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] value in
                    if value {
                        self?.startLoading()
                    }else{
                        self?.stopLoading()
                    }
                
            }
            .store(in: &cancellables)
        
        commentsViewModel.$comments
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.commentsListTableView.reloadData()
            })
            .store(in: &cancellables)
    }
    
    func setUpLoader(){
        spinner.center = view.center
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
    }
    
    func setUpTableView(){
        commentsListTableView.dataSource = self
        commentsListTableView.delegate = self
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        commentsListTableView.register(nib, forCellReuseIdentifier: CommentTableViewCell.identifier)
        commentsListTableView.rowHeight=150
        commentsListTableView.separatorStyle = .none
    }
    
    func startLoading() {
        spinner.startAnimating()
        commentsListTableView.backgroundView = spinner
    }
    
    func stopLoading() {
        spinner.stopAnimating()
        commentsListTableView.backgroundView = nil
    }
    

   

}
