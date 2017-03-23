//
//  JSONParser.swift
//  TwitterClient
//
//  Created by Elyanil Liranzo Castro on 3/20/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import Foundation

typealias JSONParserCallback = (Bool, [Tweet]?) -> Void

typealias JSONParserCallbackForUsers = (Bool, User?) -> Void

class JSONParser {

    class func tweetsFrom(data: Data, callback: JSONParserCallback) {

        do {
            if let rootObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String : Any]] {
                var tweets = [Tweet]()

                for tweetDictionary in rootObject {
                    if let tweet = Tweet(json: tweetDictionary) {
                        tweets.append(tweet)
                    }

                }

                callback(true, tweets)
            }
        } catch {

            print("Error Serializing JSON")
            callback(false, nil)
        }

    }

//    Migrate the JSON parsing code from getOAuthUser to a type method on the JSONParser class
//    Make sure to properly handle any force try! code in our API class from lecture, using the do, try, catch format.
    class func usersFrom(data: Data, callback: JSONParserCallbackForUsers) {
        do {
            if let userJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                let aUser = User(json: userJSON)
                callback(true, aUser)
            }
        } catch {
            print("Error serializing JSON")
        }
    }
}
