//
//  Post.swift
//  Admin_end
//
//  Created by Athmika Senthilkumar on 7/17/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

class Post : PFObject, PFSubclassing {
    
    var image: UIImage?
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: PFUser?
    @NSManaged var name: String?
    @NSManaged var phone: String?
    @NSManaged var address: String?
    @NSManaged var ward: String?
    @NSManaged var deliveryDate: NSDate
    @NSManaged var isSegregated: Bool
    @NSManaged var isCompleted: Bool
    @NSManaged var isFeasible: Bool
    @NSManaged var array: [String]
    @NSManaged var textSent: Bool

    var photoUploadTask: UIBackgroundTaskIdentifier?
    
    
    
    static func parseClassName() -> String
    {
        return "Post"
    }
    
   
    override init ()
    {
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
}
