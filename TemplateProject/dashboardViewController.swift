//
//  DashboardViewController.swift
//  Admin_end
//
//  Created by Athmika Senthilkumar on 7/17/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import UIKit
import Parse

class dashboardViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ward: String!
    let postsQuery = Post.query()
    var posts: [Post] = []
    var selectedIndex: NSIndexPath!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
               postsQuery!.whereKey("ward", equalTo: ward!)
        postsQuery!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            self.posts = result as? [Post] ?? []
            self.tableView.reloadData()
        }
        
    }
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
     if (segue.identifier != "MapSegue")
     {
        var postData: expandedCellViewController = segue.destinationViewController as! expandedCellViewController
        selectedIndex = self.tableView.indexPathForCell(sender as!
            UITableViewCell)
        
        postData.post = posts[selectedIndex!.row]
      }
        
      else
     {
      var postData: MapViewController = segue.destinationViewController as! MapViewController
        postData.posts = posts
     }
        
     }

}

extension dashboardViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return posts.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell") as! PostTableViewCell
    
        let date = posts[indexPath.row].createdAt
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.dateFormat = "dd-MM"
        
        let string = dateFormatter.stringFromDate(date!)
        cell.DateLabel.text = string
        cell.nameLabel.text = posts[indexPath.row].name
        
       if (posts[indexPath.row].isSegregated)
       {cell.sLabel.text = "S"}
       else
        {cell.sLabel.text = "M"}
        
        if (posts[indexPath.row].isCompleted)
        {
            cell.dotButton.image = UIImage(named: "Green")
        }
        
        else if (posts[indexPath.row].textSent)
        {
        cell.dotButton.image = UIImage(named: "Yellow")
        }
        
        
       
        
        return cell
    }

    @IBAction func unwindToListDelete(segue: UIStoryboardSegue)
    {
        posts.removeAtIndex(selectedIndex!.row)
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue)
    {
        
    }

}
