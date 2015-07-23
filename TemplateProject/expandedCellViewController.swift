//
//  expandedCellViewController.swift
//  Admin_end
//
//  Created by Athmika Senthilkumar on 7/19/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Bond
import Parse

class expandedCellViewController: UIViewController {
   
    
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var afterTextInfoLabel: UILabel!
    @IBOutlet weak var sendTextButton: UIButton!
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var completedButton: UIButton!
@IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    let geoCoder = CLGeocoder()
    var coords: CLLocationCoordinate2D!
    let userAlertQuery = UserAlert.query()
    var userAlerts: [UserAlert] = []
    var post: Post!
    var userAlert: UserAlert!
    var selectedIndex: NSIndexPath?
    
    
  
    

    override func viewDidLoad()
    {
    userAlertQuery!.whereKey("phone", equalTo: post.phone!)
    userAlertQuery!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            self.userAlerts = result as? [UserAlert] ?? []
            self.userAlert = self.userAlerts[0]
        }
        
        super.viewDidLoad()
        
        //hide date picker when the view first loads
        datePicker.enabled = false
        datePicker.hidden = true
        
        afterTextInfoLabel.hidden = true
        
        let userImageFile = post.imageFile
        userImageFile!.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if !(error != nil) {
                let image = UIImage(data:imageData!)
                 self.Image.image = image
            }
        }
        
       
       addressLabel.text = post.address
     
       
              if (post.isFeasible && !post.isCompleted)
              {
                 completedButton.hidden = false
                 completedButton.enabled = true
                 afterTextInfoLabel.hidden = false
                
               /* let dateFormatter = NSDateFormatter()
                dateFormatter.dateStyle = .ShortStyle
                dateFormatter.dateFormat = "dd-MM-YYYY"
                
          var strDate = dateFormatter.stringFromDate(post.deliveryDate)*/
                afterTextInfoLabel.text = "The collection date is "
              }
                
              else
              {
                completedButton.hidden = true
                completedButton.enabled = false
              }
        
  
        
        
    if (post.textSent || post.isCompleted)
        // if post is in progress hide segment control
          {
           
            
            sendTextButton.enabled = false
            sendTextButton.hidden = true
            
            segmentControl.enabled = false
            segmentControl.hidden = true
        }
        
        
        geocodingInternal()
    }

    @IBAction func openMaps(sender: UIButton)
    {
     geocodingExternal()
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func geocodingExternal()
    {
        
        if (addressLabel.text != nil)
        {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(addressLabel.text,
            completionHandler:
            {(placemarks: [AnyObject]!, error: NSError!) in
                
                if error != nil {
                    println("Geocode failed with error: \(error.localizedDescription)")
                }
                
                else if placemarks.count > 0 {
                    let placemark = placemarks[0] as! CLPlacemark
                    let location = placemark.location
                    self.coords = location.coordinate
                    println("\(self.coords.latitude) \(self.coords.longitude)")
                    let place = MKPlacemark(coordinate: self.coords, addressDictionary: nil)
                    let mapItem = MKMapItem(placemark: place)
                    mapItem.name = self.addressLabel.text
                    mapItem.openInMapsWithLaunchOptions(nil)
                }
                })
        }
        else {println("Address not found")}
    }
    
func geocodingInternal()
    {
if (addressLabel.text != nil)
    {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(addressLabel.text,
            completionHandler:
            {(placemarks: [AnyObject]!, error: NSError!) in
                
                if error != nil {
                    println("Geocode failed with error: \(error.localizedDescription)")
                }
                
                else if placemarks.count > 0 {
                    let placemark = placemarks[0] as! CLPlacemark
                    let location = placemark.location
                    self.coords = location.coordinate
                    let place = MKPlacemark(coordinate: self.coords, addressDictionary: nil)
                    self.displayOnMap(self.coords.latitude, Longitude: self.coords.longitude)
                }
        })
    }
    else {println("Address not found")}
    }
    
   
    
    func displayOnMap(Latitude:CLLocationDegrees, Longitude: CLLocationDegrees)
        
    {
        
        let location = CLLocation(latitude: Latitude, longitude: Longitude)
        let regionRadius: CLLocationDistance = 1000
        centerMapOnLocation(location,regionRadius: regionRadius)
    
    }
    
    
    
    func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance)
        
    {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius * 2.0, regionRadius * 2.0)
        
        var pinLocation = location.coordinate
        var objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        MapView.setRegion(coordinateRegion, animated: true)
        MapView.addAnnotation(objectAnnotation)
    }
}

   extension expandedCellViewController: UITableViewDataSource
    {
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.post.array.count;
    }
    
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:"cell")
        cell.textLabel?.text = post.array[indexPath.row]
        return cell 
    }
    }

extension expandedCellViewController
{
@IBAction func segmentedControl(sender: UISegmentedControl) {
    
    switch sender.selectedSegmentIndex
    {
    case 0:
        // Feasible so display the date entry label and field.
        
        datePicker.enabled = true
        datePicker.hidden = false
        datePicker.hidden = false
        
        post.isFeasible = true
        userAlert.isFeasible = true
        
        
    case 1:
        
        // not Feasible so hide the date entry label and field.
        datePicker.enabled = false
        datePicker.hidden = true
        datePicker.hidden = true
        
        post.isFeasible = false
        userAlert.isFeasible = false
        
    default:
        break;
    }
    
}
    
  
    @IBAction func sendtextButton(sender: UIButton)
    {
      sendText(post.isFeasible)
      post.textSent = true
      post.saveInBackground()
      userAlert.saveInBackground()
    }
    
    
    
    
    func sendText(isfeasible: Bool)
    {

     if isfeasible == true
     {
                println("Text sent (feasible)")
                self.performSegueWithIdentifier("goBack", sender: self)
        
    }
        
    else if isfeasible == false
     {
        println("Text sent (notfeasible)")
        deletePostWithoutAlert(post)
        
        }
        
        userAlert.textSent = true

    }
    
    
    
    
    @IBAction func completeButton(sender: UIButton)
    {
        
        var refreshAlert = UIAlertController(title: "Are you sure?", message: "This request will be deleted", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            
            self.userAlert.isCompleted = true
            self.deletePostWithoutAlert(self.post)
            self.userAlert.saveInBackground()
            self.performSegueWithIdentifier("goBack", sender: self)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil
        ))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
       
    }
    
    @IBAction func datePickerAction(sender: UIDatePicker) {
        post.deliveryDate = datePicker.date
    }
    
    
    //MARK: Delete
    
    
    @IBAction func deleteButton(sender: UIButton)
    {
        deletePostWithAlert(post, sender: sender)
    }
   

    
    func deletePostWithAlert(post: Post, sender: UIButton)
    {
        
            let alertController = UIAlertController(title: nil, message: "Do you want to delete this post?", preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let destroyAction = UIAlertAction(title: "Delete", style: .Destructive) { (action) in
                post.deleteInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        self.userAlert.deleted = true
                    self.userAlert.saveInBackground()
                        self.performSegueWithIdentifier("goBackDelete", sender: self)
                        
                    } else {
                        // restore old state
                        
                    }
                })
            }
            alertController.addAction(destroyAction)
        
        alertController.popoverPresentationController?.sourceView = sender as UIView;
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    
    
    
    
    func deletePostWithoutAlert(post: Post)
    {
        post.deleteInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
            if (success) {
                self.performSegueWithIdentifier("goBackDelete", sender: self)
                
            } else {
                // restore old state
                
            }
        })
    
    }
    
   
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


