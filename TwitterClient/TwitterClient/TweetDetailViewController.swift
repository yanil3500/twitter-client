//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by Elyanil Liranzo Castro on 3/22/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    var tweet: Tweet!

    @IBOutlet weak var tweetDetailViewTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TweetDetailViewController
        self.tweetDetailViewTable.dataSource = self
        self.tweetDetailViewTable.delegate = self
        
        //Register tweet nib for reuse; Tell the tableview to use the tweet nib for its cell
         let tweetNib = UINib(nibName: "TweetNibCell", bundle: nil)
        self.tweetDetailViewTable.register(tweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
        
        self.tweetDetailViewTable.estimatedRowHeight = 50
        self.tweetDetailViewTable.rowHeight = UITableViewAutomaticDimension
        
        print("Inside of TweetDetailViewController: \(tweet.text)\nNumber of retweets: \(tweet.retweeted_count)\nScreenname:\(tweet.user?.screenName)")
       
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Dequeues (removes from the queue)
        let tweetCell = tableView.dequeueReusableCell(withIdentifier: TweetNibCell.identifier, for: indexPath) as! TweetNibCell
        
        let tweet = self.tweet
        
        //Sends tweet information to our TweetNibCell class
        tweetCell.tweet = tweet
        
        return tweetCell
        
    }
    

}
