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
    
    
    var tweetArr = [Tweet](){
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
   
        
        //Our HomeTimelineViewController 
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
        //Gets tweets from twitter api
        self.updateTimeLine()
        
    }

    func updateTimeLine(){
        print("Checking to see if segmented switch called updateTimeLine")
        API.shared.getTweets { (tweets) in
            guard let tweets = tweets else { fatalError("Tweets came back nil.") }
            
            //Access OperationQueue.main singleton as add ui elements to the main thread
//            Reload the tableView on the main thread (aka: main queue) once you are done parsing the JSON data from the request.
            OperationQueue.main.addOperation {
                self.tweetArr = tweets
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Dequeues (removes from the queue)
        let tweetCell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)

        
        let tweet = tweetArr[indexPath.row]
        
        tweetCell.textLabel?.text = tweet.text
        tweetCell.detailTextLabel?.text = tweet.user?.userName
        return tweetCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tweet at:\(indexPath.row)")
    }


}
