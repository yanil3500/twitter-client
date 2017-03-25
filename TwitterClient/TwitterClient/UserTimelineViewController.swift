//
//  UserTimelineViewController.swift
//  TwitterClient
//
//  Created by Elyanil Liranzo Castro on 3/23/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userTimeLineImage: UIImageView!
    @IBOutlet weak var userTimeLineTableView: UITableView!
    
    var userProfile : User!
    
    var userTweets = [Tweet](){
        didSet {
            self.userTimeLineTableView.reloadData()
        }
    }
    
    func updateTimeLine(){
        API.shared.getTweetsFor(self.userProfile.screenName) { (tweets) in
            guard let tweets = tweets else { fatalError("Tweets came back nil.") }
            print("Inside of updateTimeLine in UserTimeLineViewController (attempts to get tweets from other user): \(tweets) ")
            
            OperationQueue.main.addOperation {
                self.userTweets = tweets
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "User Timeline"
        print("Inside of userTimeLineViewController: \(userProfile.screenName)")
        
        //get user profile pic 
        
        UIImage.fetchImageWith(userProfile.profilePicURL) { (image) in
            self.userTimeLineImage.image = image
        }
        
        //Our UserTimeLineViewController
        self.userTimeLineTableView.dataSource = self
        self.userTimeLineTableView.delegate = self

        //Register tweet nib for reuse; Tell the tableview to use the tweet nib for its cell
        
        self.userTimeLineTableView.estimatedRowHeight = 50
        self.userTimeLineTableView.rowHeight = UITableViewAutomaticDimension
        
        
        //Register tweet nib for reuse; Tell the tableview to use the tweet nib for its cell
        
        let tweetNib = UINib(nibName: "TweetNibCell", bundle: nil)
        
        //Gets tweets from twitter api
        self.updateTimeLine()
        
        self.userTimeLineTableView.register(tweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Dequeues (removes from the queue)
        let tweetCell = tableView.dequeueReusableCell(withIdentifier: TweetNibCell.identifier, for: indexPath) as! TweetNibCell
        
        let tweet = self.userTweets[indexPath.row]
        
        //Sends tweet information to our TweetNibCell class
        tweetCell.tweet = tweet
        
        return tweetCell

    }
    
}
