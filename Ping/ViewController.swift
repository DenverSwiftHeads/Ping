//
//  ViewController.swift
//  Ping
//
//  Created by Derek Bassett on 3/26/16.
//  Copyright © 2016 Two Cavemen LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SimplePingerDelegate {

    var localPinger:SimplePinger?
    var routerPinger:SimplePinger?
    var googlePinger:SimplePinger?
    var sendTimer:NSTimer?
    
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var sentLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        localPinger = SimplePinger(hostName:"192.168.1.1")
        localPinger?.delegate = self
    }

    override func viewDidAppear(animated: Bool) {
        localPinger?.start()
    }
    override func viewWillDisappear(animated: Bool) {
        localPinger?.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma: Delegate
    func startWithAddress(simplePinger: SimplePinger, hostName: String) {
        if(simplePinger == localPinger){
            hostLabel.text = hostName
        }
    }
    
    func sentPing(simplePinger: SimplePinger, sequenceNumber: String) {
        if(simplePinger == localPinger) {
            sentLabel.text = "\(sequenceNumber) sent"
        }
    }
    
    func failWithError(simplePinger: SimplePinger, error: String) {
        if(simplePinger == localPinger) {
            errorLabel.text = "\(error) error"
        }
    }

}

