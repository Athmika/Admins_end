//
//  userAlert.swift
//  Admin_end
//
//  Created by Athmika Senthilkumar on 7/22/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//
import UIKit
import Parse

class UserAlert : PFObject, PFSubclassing
{
    
    
    @NSManaged var phone: String?
    @NSManaged var isCompleted: Bool
    @NSManaged var isFeasible: Bool
    @NSManaged var textSent: Bool
    @NSManaged var deleted: Bool
    
    @NSManaged var userConfirmed: Bool
    
    static func parseClassName() -> String {
        return "UserAlert"
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