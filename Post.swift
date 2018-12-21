//
//  Post.swift
//  AlamofireTutorial
//
//  Created by Sreng Khorn on 17/12/18.
//  Copyright © 2018 Sreng Khorn. All rights reserved.
//

import Foundation
import ObjectMapper

struct Post: Mappable {
    var id: Int?
    var title: String?
    var imageUrl: String?
    var description: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["ID"]
        title    <- map["TITLE"]
        imageUrl <- map["IMAGE"]
        description <- map["DESCRIPTION"]
    }
}
