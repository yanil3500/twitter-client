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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Inside of ProfileViewController: \(userProfile.profileDescription)")
        
        
    }

}
