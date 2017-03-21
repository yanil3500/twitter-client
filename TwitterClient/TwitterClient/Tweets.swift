//
//  Tweets.swift
//  TwitterClient
//
//  Created by Elyanil Liranzo Castro on 3/20/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import Foundation

class Tweets {
    static let shared = Tweets()
    
    var tweets = [Tweet]()
    
    private init (){}
    
    func add(tweet: Tweet){
        self.tweets.append(tweet)
    }
    
    func remove(tweet: Tweet){
        self.tweets = self.tweets.filter{
            (item) -> Bool in
            return tweet.id != item.id
        }
    }
    
    func removeAll() {
        self.tweets.removeAll()
    }
    
    func getTweetAt(indexOf: Int) -> Tweet{
        return self.tweets[indexOf]
    }
    
    func count () -> Int {
        return self.tweets.count
    }
    
    func allTweets () -> [Tweet] {
        return self.tweets
    }
    
    
    
    
}
