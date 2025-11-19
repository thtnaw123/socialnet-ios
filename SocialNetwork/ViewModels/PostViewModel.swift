//
//  PostViewModel.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 17/11/2025.
//

import Combine
import Foundation

class PostViewModel{
    @Published private(set) var posts: [PostModel] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String? = nil

    private var cancellables = Set<AnyCancellable>()
    let postApiService:APIServices
    
    init(postServices:APIServices) {
        self.postApiService = postServices
    }
    
    
    func fetchPosts(){
        isLoading = true
        errorMessage = nil
        postApiService.getPosts()
            .sink(receiveCompletion:{ [weak self] completion in
                self?.isLoading=false
                switch completion{
                case .failure(let error):
                    self?.errorMessage=error.localizedDescription
                case .finished:
                    break
                }
            }
                  ,receiveValue: {[weak self] value in self?.posts = value})
            .store(in: &cancellables)
    }
    
   
    
    
}
