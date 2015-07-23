//
//  PasswordViewController.swift
//  Admin_end
//
//  Created by Athmika Senthilkumar on 7/19/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//
import Parse
import UIKit

class PasswordViewController: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    var password: String = "0"
    
        override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func nextButton(sender: AnyObject) {
        if passwordText.text != password
        {
            var alert = UIAlertController(title: "Alert", message: "The password is incorrect", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
