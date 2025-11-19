//
//  UserViewModel.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 18/11/2025.
//

import Foundation
import Combine

class UserViewModel{
    @Published private(set) var user:UserModel? = nil
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    let postApiService:APIServices
    
    init(postServices:APIServices) {
        self.postApiService = postServices
    }
    
    
    func fetchUser(userId:Int){
        isLoading = true
        errorMessage = nil
        postApiService.getUser(userId: userId)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: {[weak self]value in
                self?.user=value
            })
            .store(in: &cancellables)
    }
    
    
}
