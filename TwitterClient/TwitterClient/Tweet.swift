//
//  Tweet.swift
//  TwitterClient
//
//  Created by Elyanil Liranzo Castro on 3/20/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import Foundation

class Tweet {
    
    let tweetText : String
    let tweetID : String

    var user : User?
    
    //Sets faillable initializer (denoted by ? next to init keyword)
    init?(json: [String : Any]) {
        if let text = json["text"] as? String, let id = json["id_str"] as? String {
            self.tweetText = text
            self.tweetID = id
            //Checks if value is non-nil
            if let userDictionary = json["user"] as? [String : Any]{
                self.user = User(json: userDictionary)
            }
        } else {
            return nil
        }
    }
}
