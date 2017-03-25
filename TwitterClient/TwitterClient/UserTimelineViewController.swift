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
    
    var userTweet = [Tweet](){
        didSet {
            self.userTimeLineTableView.reloadData()
        }
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "User Timeline"
        print("Inside of userTimeLineViewController: \(userProfile.screenName)")
        
        //get user profile pic 
        
        UIImage.fetchImageWith(userProfile.profilePißcURL) { (image) in
            self.userTimeLineImage.image = image
        }
        
        //Our UserTimeLineViewController
        self.userTimeLineTableView.dataSource = self
        self.userTimeLineTableView.delegate = self

        //Register tweet nib for reuse; Tell the tableview to use the tweet nib for its cell
        
        self.userTimeLineTableView.estimatedRowHeight = 50
        self.userTimeLineTableView.rowHeight = UITableViewAutomaticDimension
        
        let tweetNib = UINib(nibName: "TweetNibCell", bundle: nil)
        
        self.userTimeLineTableView.register(tweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}
