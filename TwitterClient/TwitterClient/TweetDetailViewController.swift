//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by Elyanil Liranzo Castro on 3/22/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    @IBOutlet weak var detailTweet: UILabel!
    
    var tweet : Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Inside of TweetDetailViewController: \(tweet.text)\nNumber of retweets: \(tweet.retweeted_count)")
        
        detailTweet.text = "\(tweet.text)nNumber of retweets: \(tweet.retweeted_count)"
        
    }


}
