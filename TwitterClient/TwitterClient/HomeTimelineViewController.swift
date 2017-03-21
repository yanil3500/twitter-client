//
//  HomeTimelineViewController.swift
//  TwitterClient
//
//  Created by Elyanil Liranzo Castro on 3/20/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Our HomeTimelineViewController 
        self.tableView.dataSource = self
        self.tableView.delegate = self

        JSONParser.tweetsFrom(data: JSONParser.sampleJSON) { (success, tweets) in
            if (success) {
                guard let tweets = tweets else {
                    fatalError("Tweets came back nil.")
                }
                for tweet in tweets {
                    print("Tweets: \(tweet.text)")
                    //Adds list of tweets to shared instance of Tweets class
                    Tweets.shared.add(tweet: tweet)
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Tweets.shared.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Dequeues (removes from the queue)
        let tweetCell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
        
        
        //Makes local, mutable copy
        var tweetArr = Tweets.shared.allTweets()
        
        let tweet = tweetArr[indexPath.row]
        
        tweetCell.textLabel?.text = tweet.text
        tweetCell.detailTextLabel?.text = tweet.user?.userName
        return tweetCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tweet at:\(indexPath.row)")
    }


}
