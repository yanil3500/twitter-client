//
//  Tweet.swift
//  TwitterClient
//
//  Created by Elyanil Liranzo Castro on 3/20/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import Foundation

class Tweet {

    let text: String
    let id: String
    let retweeted : Bool
    let retweeted_count : Int
    var user: User?

    //Sets faillable initializer (denoted by ? next to init keyword)
    init?(json: [String : Any]) {
        if let tweetText = json["text"] as? String, let tweetID = json["id_str"] as? String, let hasBeenRetweeted = json["retweeted"] as? Bool, let numOfRetweets = json["retweet_count"] as? Int {
            self.text = tweetText
            self.id = tweetID
            self.retweeted = hasBeenRetweeted
            self.retweeted_count = numOfRetweets
            //Checks if value is non-nil
            if let userDictionary = json["user"] as? [String : Any] {
                self.user = User(json: userDictionary)
            }
        } else {
            return nil
        }
    }
}
