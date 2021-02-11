//
//  DataModel.swift
//  Skynet
//
//  Created by Ios development on 09/02/21.
//  Copyright © 2021 Ios development. All rights reserved.
//

import Foundation
import UIKit

struct DataModel {
    var userId : Int?
    var id : Int?
    var title : String
    var body : String
    
    init(_ dictionary : [String:Any]) {
        self.userId = dictionary["userId"] as? Int ?? 0
        self.id = dictionary["id"] as? Int ?? 0
        self.title = dictionary["title"] as? String ?? ""
        self.body = dictionary["body"] as? String ?? ""
    }
    
    init() {
        self.userId = 0
        self.id =  0
        self.title = ""
        self.body =  ""
    }
}
