//
//  MapViewController.swift
//  Admin_end
//
//  Created by Athmika Senthilkumar on 7/23/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class MapViewController: UIViewController {
 
    var posts: [Post] = []
      var coords: CLLocationCoordinate2D!
    @IBOutlet weak var MapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allposts()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func allposts()
    {
    
        for post in posts
        {
           if (post.isFeasible == true)
            {
             geocodingInternal(post.address!)
            }
        }
    }
    
    func geocodingInternal(address:String)
    {
        
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(address,
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
