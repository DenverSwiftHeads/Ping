//
//  ViewController.swift
//  Ping
//
//  Created by Derek Bassett on 3/26/16.
//  Copyright © 2016 Two Cavemen LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SimplePingDelegate {

    var pinger:SimplePing?
    var sendTimer:NSTimer?
    
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var sentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pinger = SimplePing(hostName:"192.168.1.1")
        pinger?.delegate = self
    }

    override func viewDidAppear(animated: Bool) {
        pinger?.start()
    }
    override func viewWillDisappear(animated: Bool) {
        pinger?.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func sendPing(){
        pinger?.sendPingWithData(nil)
    }
    
    // #pragma: Delegate
    func simplePing(pinger: SimplePing!, didStartWithAddress address: NSData!) {
        assert(self.pinger == pinger)
        
        print("pinging ", DisplayAddressForAddress(address))
        
        hostLabel.text = DisplayAddressForAddress(address)
        
        sendPing()
        
        sendTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: #selector(ViewController.sendPing), userInfo: nil, repeats: true)
    }
    
    func simplePing(pinger: SimplePing!, didSendPacket: NSData!) {
        assert(self.pinger == pinger)
        
        let sequenceNumber = SequenceNumber(didSendPacket)
        print(sequenceNumber, "sent")
        
        sentLabel.text = "\(sequenceNumber) sent"
    }

}

