//
//  PostApiServices.swift
//  SocialNetwork
//
//  Created by Tihitinaw Buzuwek on 17/11/2025.
//

import Foundation
import Combine

class APIServices{
    
    var cancellables = Set<AnyCancellable>()
    
    
    func fetchFeeds() ->AnyPublisher<[FeedItem],Error>{
          let endPoints = APIConfig.fetchPostsEndPoints
          let future: Future<[PostModel],Error> = getData(endPoints: endPoints)
          
          return future.flatMap{ posts in
              let userPubs = posts.compactMap{[weak self] post in
                   self?.getUser(userId: post.userId)
                      .map{
                          user in FeedItem(post: post, user: user)
                      }
                      .eraseToAnyPublisher()
                      
              }
              return Publishers.MergeMany(userPubs)
                  .collect()
                  .eraseToAnyPublisher()
          }
          .eraseToAnyPublisher()
      }

  
    
    func getPosts()->Future<[PostModel],Error>{
        let endPoints = APIConfig.fetchPostsEndPoints
        let future: Future<[PostModel],Error> = getData(endPoints: endPoints)
        return future
    }

    
    func getUsers()->Future<[UserModel],Error>{
        let endPoints = APIConfig.fetchUsersURL
        let future: Future<[UserModel],Error> = getData(endPoints: endPoints)
        return future
    }
    
    func getUser(userId:Int) -> Future<UserModel,Error>{
        let endPoints = "\(APIConfig.fetchUsersURL)/\(userId)"
        let future: Future<UserModel,Error> = getData(endPoints: endPoints)
        return future
    }
    
    func getPostComments(postId:Int)-> Future<[CommentsModel], Error> {
        let endPoints = "\(APIConfig.fetchCommentsURL)/\(postId)/comments"
        let future: Future<[CommentsModel],Error> = getData(endPoints: endPoints)
        return future
    }
    
    
    func getPost(postId:Int){}
    
    func addPost(){}
    
    func editPost(postId:Int){}
    
    func deletePost(postId:Int){}
    
    
    
    
    
    
    private func getData<T:Decodable>(endPoints:String) -> Future<T, Error>{
        return Future<T, Error> {  promise in
            
            guard let url = URL(string: endPoints) else {
                return promise(.failure(NetworkErrorModel.invalidURL))
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap{data, response -> Data in
                    guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode)else{
                         promise(.failure(NetworkErrorModel.invalidResponse))
                        throw NetworkErrorModel.invalidResponse
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    switch completion {
                        case .finished:
                            PrintDebug.printDebug("posts received")
                        case .failure(let error):
                            promise(.failure(error))
                    }
                    
                },
                  receiveValue: { value in
                    promise(.success(value))
                  }
                )
                .store(in: &self.cancellables)
        }
       
    }
}
