//
//  UIExtensions.swift
//  TwitterClient
//
//  Created by Elyanil Liranzo Castro on 3/23/17.
//  Copyright © 2017 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit


extension UIImage {
    
    typealias ImageCallback = (UIImage?)->()
    
    class func fetchImageWith(_ urlString: String, callback: @escaping ImageCallback){
        OperationQueue().addOperation {
            guard let url = URL(string: urlString) else { callback(nil); return }
            
            //Optional try, so that if Data(contentsOf:) fails, nil gets assigned into data
            if let data = try? Data(contentsOf: url) {
                
                guard let image = UIImage(data: data) else { fatalError("Image not found")}
                print("Inside of UIExtensions: \(image)")
                OperationQueue.main.addOperation {
                    callback(image)
                }
            } else {
                OperationQueue.main.addOperation {
                    callback(nil)
                }
            }
           
        }
        
    }
}


//Gives global identifier to any class that conforms to UIResponder (all views conform to the UI responder)
//Useful in situations in seugues identifiers are need
extension UIResponder {
    static var identifier : String {
        return String(describing: self)
    }
}
