//
//  PostListRemoteDataManager.swift
//  iOS-Viper-Architecture
//
//  Created by Amit Shekhar on 18/02/17.
//  Copyright © 2017 Mindorks NextGen Private Limited. All rights reserved.
//

import Foundation
import Alamofire

class PostListRemoteDataManager:PostListRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: PostListRemoteDataManagerOutputProtocol?
    
    func retrievePostList() {
        Alamofire
            .request(Endpoints.Posts.fetch.url, method: .get)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    let responseData = response.data!
                    do {
                        let decoder = try JSONDecoder().decode([PostModel].self, from: responseData)
                        self.remoteRequestHandler?.onPostsRetrieved(decoder)
                    } catch DecodingError.keyNotFound(_, let context) {
                        print("Debug Description \(context.debugDescription)")
                        self.remoteRequestHandler?.onError()
                    } catch DecodingError.typeMismatch(_, let context) {
                        print("Debug Description \(context.debugDescription)")
                        self.remoteRequestHandler?.onError()
                    } catch DecodingError.valueNotFound(_, let context) {
                        print("Debug Description \(context.debugDescription)")
                        self.remoteRequestHandler?.onError()
                    } catch DecodingError.dataCorrupted(let context) {
                        print("Debug Description \(context.debugDescription)")
                        self.remoteRequestHandler?.onError()
                    } catch let error {
                        print("Otherwise Debug Description \(error)")
                        self.remoteRequestHandler?.onError()
                    }
                case .failure(let context):
                    print("Alamofire context error \(context)")
                    self.remoteRequestHandler?.onError()
                }
        }
    }
    
}
