//
//  TableViewController.swift
//  Ping
//
//  Created by Derek Bassett on 4/13/16.
//  Copyright © 2016 Two Cavemen LLC. All rights reserved.
//

import UIKit

class PingTableViewController: UITableViewController, SimplePingerDelegate {
    
    var pingers: [SimplePinger] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pingers.append(SimplePinger(hostName: "127.0.0.1"))
        pingers.append(SimplePinger(hostName: "192.168.1.1"))
        pingers.append(SimplePinger(hostName: "192.168.100.1"))
        pingers.append(SimplePinger(hostName: "8.8.8.8"))
        
        for pinger in pingers {
            pinger.delegate = self
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        for pinger in pingers {
            pinger.start()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        for pinger in pingers {
            pinger.stop()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pingers.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PingTableViewCell", forIndexPath: indexPath) as! PingTableViewCell
        let pinger = pingers[indexPath.row]
        
        cell.hostLabel.text = pinger.hostName
        cell.statusLabel.text = "\(pinger.state.rawValue)"
        
        return cell
    }
    
    func startWithAddress(simplePinger: SimplePinger, hostName: String) {
        self.tableView.reloadData()
    }
    
    func sentPing(simplePinger: SimplePinger, sequenceNumber: String) {
        self.tableView.reloadData()
    }
    
    func failWithError(simplePinger: SimplePinger, error: String) {
        self.tableView.reloadData()
    }
    
    func failToSendPacket(simplePinger: SimplePinger, error: String) {
        self.tableView.reloadData()
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
