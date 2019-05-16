//
//  WebManager.swift
//  RemoteAssistant
//
//  Created by Maseeh Ahmed on 3/27/19.
//  Copyright © 2019 talat. All rights reserved.
//

import UIKit
import Alamofire

class WebManager: NSObject {

    class func GetArticleInfoFromApi(withCompletionHandler: @escaping (_ response:[String:AnyObject]?)->(Void) ) {
        
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            
        ]
        
        let url = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=" + AppStrings.Apikey
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseString { responseString in
            
            if((responseString.result.value) != nil) {
                do{
                    let json = try JSONSerialization.jsonObject(with: responseString.data!, options: []) as? [String: AnyObject]
                    print("json: ", json!["status"] as! String)
                    withCompletionHandler(json)
                } catch let error {
                    print("Error: \(error)")
                }

                withCompletionHandler(nil)
            }else{
                withCompletionHandler(nil)
            }
            
        }
    }
}
