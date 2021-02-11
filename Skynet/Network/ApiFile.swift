//
//  ApiFile.swift
//  Skynet
//
//  Created by Ios development on 08/02/21.
//  Copyright © 2021 Ios development. All rights reserved.
//

import Foundation
import UIKit

class ApiFile {

static let shared = ApiFile()
    
private init() {}

func callGet(url: URL, finish: @escaping ((message:String, data:Data?)) -> Void) {
    
   
    let request = NSMutableURLRequest(url: url as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
  //  request.addValue("EV6FTlgBhOalM+qjJpr2OZpAEpPkYJHC5I1aOWyeLevwSIpuzyKEAg==", forHTTPHeaderField: "AndroidPhone")
    request.httpMethod = "GET"
   // request.addValue("Bearer \(UserDefaults.standard.string(forKey: "Tocken") ?? "")" , forHTTPHeaderField: "Authorization")
   // request.allHTTPHeaderFields = headers
    
    let session = URLSession.shared
    var result:(message:String, data:Data?) = (message: "Fail", data: nil)
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if (error != nil) {
            result.message = "\(error?.localizedDescription ?? "")"
             
        } else {
            if let httpResponce = response as? HTTPURLResponse{
                print("status Code : \(httpResponce.statusCode)" )
                if httpResponce.statusCode == 401{
                    print("Refresh token...")
                    
                    return
                }
            }
            
            result.message = "Success"
            result.data = data
        }
        finish(result)
    })
    
    dataTask.resume()
}

}

