//
//  TweetNibCell.swift
//  TwitterClient
//
//  Created by Elyanil Liranzo Castro on 3/23/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class TweetNibCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    var tweet : Tweet! {
        didSet {
            self.tweetLabel.text = tweet.text
            self.usernameLabel.text = tweet.user?.userName ?? "Unknown User"
            
            guard let user = tweet.user else { fatalError("Unknown user")}
            print("Inside of TweetNibCell: \(user.profilePicURL)")
            UIImage.fetchImageWith(user.profilePicURL) { (image) in
                self.userImageView.image = image
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
