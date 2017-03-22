//
//  User.swift
//  TwitterClient
//
//  Created by Elyanil Liranzo Castro on 3/20/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import Foundation

class User {

    let userName: String
    let profilePicURL: String
    let location: String

    init?(json: [String : Any]) {
        if let userName = json["name"] as? String, let profilePicURL = json["profile_image_url"] as? String, let location = json["location"]  as? String {
            self.userName = userName
            self.profilePicURL = profilePicURL
            self.location = location
        } else {
            return nil
        }
    }

}
