//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Elyanil Liranzo Castro on 3/22/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var userProfile : User!
    
    @IBOutlet weak var twitterUserName: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var profileDescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Inside of ProfileViewController: \(userProfile.profileDescription)")
        
        
        twitterUserName.text = "Username: \(userProfile.userName)"
        userLocation.text = "Location: \(userProfile.location)"
        screenName.text = "Screenname: \(userProfile.screenName)"
        profileDescription.text = "Description: \(userProfile.profileDescription)"
        
    }

}
