//
//  API.swift
//  TwitterClient
//
//  Created by Elyanil Liranzo Castro on 3/21/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import Foundation
import Accounts
import Social

//Declare typealiases

typealias AccountCallback = (ACAccount?) -> Void
typealias UserCallback = (User?) -> Void
typealias TweetsCallback = ([Tweet]?) -> Void

class API {

    static let shared = API()

    private init () {}

    var userAccount: ACAccount?

    //login() uses ACAccountStore from Accounts type

    //@escaping indicate that the passed in callback will be able to escape the enclosing function to pass data
    private func login(callback: @escaping AccountCallback) {
        //Gets Twitter account from device

        let accountStore = ACAccountStore()

        //Gets the type of login information
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)

        accountStore.requestAccessToAccounts(with: accountType, options: nil) { (success, error) in

            if let error = error {
                print("Error: \(error.localizedDescription)")
                callback(nil)
                return
            }

            if success {
                //if collection of accounts comeback, access the first account and cast it as an ACAccount type
                if let account = accountStore.accounts(with: accountType).first as? ACAccount {
                    print("The Twitter accounts of device: \(account)")
                    callback(account)
                }
            } else {
                print("The user did not allow access to his/her account.")
                callback(nil)
            }
        }
    }

    //Implements the SLRequest from Social type
     private func getOAuthUser(callback: @escaping UserCallback) {
        //Authenticates credentials with Twitter
        let url = URL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")

        //The following line will make a get request to twitter API
        //The SLRequest
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil) {

            //Needs account info to make request
            request.account = self.userAccount

            request.perform(handler: { (data, response, error) in

                //Accounts for error
                if let error = error {
                    print("Error: \(error)")
                    callback(nil)
                    return
                }

                guard let response = response else { callback(nil); return}

                guard let data = data else { callback(nil); return}

                //Make sure to have individual cases for the 400-499 range, and the 500-599 range. Each of these cases should print() their case specific errors(either that the error is from our client, or the error is happening server-side.)
                switch response.statusCode {
                case 200...299:
//                    Migrate the JSON parsing code from getOAuthUser to a type method on the JSONParser class?
                   JSONParser.usersFrom(data: data, callback: { (success, aUser) in
                    if success {
                        callback(aUser)
                    }
                   })
                    print("Response successful")
                default:
                    print("Error: response came back with statusCode: \(response.statusCode)")
                    callback(nil)
                }

            })
        }

    }

    //Mark a callback as escaping if its being used asynchronously
    
    //Add url parameter to make updateTimeLine more dynamic
    private func updateTimeLine(url: String, callback: @escaping TweetsCallback) {
        
//        let url = URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
        

        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: URL(string: url), parameters: nil) {

            request.account = self.userAccount

            request.perform(handler: { (data, response, error) in

                //Handle errors first

                if let error = error {
                    print("Error: Error requesting user's home timeline\(error)")
                    callback(nil)
                    return
                }

                guard let response = response else { callback(nil); return }

                guard let data = data else { callback(nil); return }

                switch response.statusCode {
                case 200...299:
                    JSONParser.tweetsFrom(data: data, callback: { (success, tweets) in
                        if success {
                            callback(tweets)
                        }
                    })
                    print("Response successful")
                case 300...399:
                    print("Error: User will be redirected. Status code: \(response.statusCode)")
                case 400...499:
                    print("Error: Client-Side error. Status code:\(response.statusCode)")
                case 500...599:
                    print("Error: Server-side error. Status code: \(response.statusCode)")
                default:
                    print("Error: response came back with status code: \(response.statusCode)")
                    callback(nil)
                }

            })
        }
    }

    //Public facing function
    func getTweets(callback: @escaping TweetsCallback) {
        if self.userAccount == nil {
            self.login(callback: { (account) in
                guard let account = account else {
                    print("Inside of getTweets: ")
                    callback(nil)
                    return
                }
                self.userAccount = account
                self.updateTimeLine(url: "https://api.twitter.com/1.1/statuses/home_timeline.json", callback: { (tweets) in
                    callback(tweets)
                })
            })
        } else {
            self.updateTimeLine(url: "https://api.twitter.com/1.1/statuses/home_timeline.json", callback: { (tweets) in
                callback(tweets)
            })
        }
    }

    func getUser(callback: @escaping UserCallback) {
        self.getOAuthUser { (aUser) in
            guard let userProfile = aUser else { fatalError("Could not access user profile") }
            callback(userProfile)
        }
    }
    
    func getTweetsFor(_ user: String, callback: @escaping TweetsCallback){
        
        let urlString = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(user)"
        self.updateTimeLine(url: urlString) { (tweets) in
            callback(tweets)
        }
    }

}
