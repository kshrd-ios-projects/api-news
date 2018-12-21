//
//  PostDAO.swift
//  AlamofireTutorial
//
//  Created by Sreng Khorn on 17/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import Foundation
import Alamofire

class PostDAO {
    static var posts = [Post]()
    
    func fetchData(resquestUrl: String, completion: @escaping ([Post]) -> Void) {
        
        Alamofire.request(resquestUrl).responseJSON { response in
            if let JSON = response.result.value {
                
                guard let dictData = JSON as? [String: Any] else { return }
                guard let arrayData = dictData["DATA"] as? NSArray else { return }
                
                for item in arrayData {
                    guard let postData = item as? [String: Any] else { return }
                    PostDAO.posts.append((Post(JSON: postData))!)
                    completion(PostDAO.posts)
                }
                
            }
        }
    }
    
}
