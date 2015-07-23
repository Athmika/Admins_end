//
//  WardViewController.swift
//  Admin_end
//
//  Created by Athmika Senthilkumar on 7/17/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit

class WardViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    var ward: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    var wards = ["1","2","3","4","5","6"]
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return wards.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        ward = wards[row]
        return wards[row]
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ward = wards[row]
    }
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.    }
    */

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller
        
        
        
     var wardNo: dashboardViewController = segue.destinationViewController as! dashboardViewController
        wardNo.ward = ward

    }
    
}
