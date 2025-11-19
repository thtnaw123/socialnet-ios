//
//  FeedsViewModel.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 19/11/2025.
//

import Foundation
import Combine

class FeedsViewModel{
    @Published private(set) var feeds:[FeedItem] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String? = nil
    
    var cancellables = Set<AnyCancellable>()
    let apiService:APIServices
    
    init(apiService: APIServices) {
        self.apiService = apiService
    }
    
    
    func fetchPostFeed(){
        isLoading = true
        errorMessage = nil
        apiService.fetchFeeds()
            .sink(receiveCompletion:{ [weak self] completion in
                self?.isLoading=false
                switch completion{
                case .failure(let error):
                    self?.errorMessage=error.localizedDescription
                case .finished:
                    break
                }
            }
                  ,receiveValue: {[weak self] value in self?.feeds = value})
            .store(in: &cancellables)
    }
    
    
    
    
}
