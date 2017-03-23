//
//  HomeTimelineViewController.swift
//  TwitterClient
//
//  Created by Elyanil Liranzo Castro on 3/20/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var tweetArr = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    var profile: User?

    override func viewDidLoad() {

        super.viewDidLoad()

        self.navigationItem.title = "My Timeline"

        //Our HomeTimelineViewController 
        self.tableView.dataSource = self
        self.tableView.delegate = self

        //TweetCellViewController
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        //Gets tweets from twitter api
        self.updateTimeLine()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == "showDetailSegue" {
            //do some things
            print("Inside of prepare(for segue): Before getting selected tweet")

            if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                let selectedTweet = self.tweetArr[selectedIndex]
                guard let destinationController = segue.destination as? TweetDetailViewController else { return }
                print("Inside of prepare(for segue): \(selectedTweet)")
                destinationController.tweet = selectedTweet
            }
        }

        if segue.identifier == "showProfileSegue" {
            print("Inside of prepare(for segue) in ProfileViewController")

            guard let destinationController = segue.destination as? ProfileViewController else { return }

            destinationController.userProfile = self.profile
        }

    }

    func updateTimeLine() {
        print("Checking to see if segmented switch called updateTimeLine")
        activityIndicator.startAnimating()
        API.shared.getTweets { (tweets) in
            guard let tweets = tweets else { fatalError("Tweets came back nil.") }

            //Access OperationQueue.main singleton as add ui elements to the main thread
//            Reload the tableView on the main thread (aka: main queue) once you are done parsing the JSON data from the request.

            API.shared.getUser(callback: { (aUser) in
                guard let userProfile = aUser else { fatalError("Cannot access profile") }

                OperationQueue.main.addOperation {
                    self.profile = userProfile
                }
            })

            OperationQueue.main.addOperation {

                self.activityIndicator.stopAnimating()
                self.tweetArr = tweets

            }

        }

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Dequeues (removes from the queue)x
        let tweetCell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellViewController

        tweetCell.tweetText.text = tweetArr[indexPath.row].text

        return tweetCell

    }

}
