//
//  ViewController.swift
//  Ping
//
//  Created by Derek Bassett on 3/26/16.
//  Copyright © 2016 Two Cavemen LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SimplePingDelegate {

    var simplePing:SimplePing = SimplePing(hostName:"8.8.8.8")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        simplePing.delegate = self
    }

    override func viewDidAppear(animated: Bool) {
        simplePing.start()
    }
    override func viewWillDisappear(animated: Bool) {
        simplePing.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func simplePing(pinger: SimplePing!, didStartWithAddress address: NSData!) {
        assert(simplePing == pinger)
        
        debugPrint("pinging ", address);
    }

}

