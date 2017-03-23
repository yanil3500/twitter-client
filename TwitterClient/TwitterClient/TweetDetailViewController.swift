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

    @IBOutlet weak var twitterHandle: UILabel!

    @IBOutlet weak var numberOfTweets: UILabel!
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Inside of TweetDetailViewController: \(tweet.text)\nNumber of retweets: \(tweet.retweeted_count)\nScreenname:\(tweet.user?.screenName)")

        twitterHandle.text = "\(tweet.user!.screenName)"

        detailTweet.text = "\(tweet.text)"

        numberOfTweets.text = "Number of Retweets: \(tweet.retweeted_count)"

        if tweet.retweeted_count < 1 {
            numberOfTweets.isHidden = true

        }

    }
}
