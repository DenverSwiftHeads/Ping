//
//  Pinger.swift
//  Ping
//
//  Created by Derek Bassett on 4/7/16.
//  Copyright © 2016 Two Cavemen LLC. All rights reserved.
//

import Foundation

/**
 * have to be derived off of NSObject because SimplePingDelegate is Object C object.
 */
@objc class SimplePinger : NSObject, SimplePingDelegate {
   
    var pinger: SimplePing?
    var timer: NSTimer?
    var delegate: SimplePingerDelegate?
    
    init(hostName: String) {
        super.init()
        pinger = SimplePing(hostName: hostName)
        pinger?.delegate = self
        pinger?.start()
    }
    
    func start() {
        
    }
    
    func stop() {
        timer?.invalidate()
    }
    
    func sendPing() {
        pinger?.sendPingWithData(nil)
    }
    
    // #pragma: Delegate
    func simplePing(pinger: SimplePing, didStartWithAddress address: NSData) {
        assert(self.pinger == pinger)
        
        let hostName = DisplayAddressForAddress(address)
        
        print("pinging ", hostName)
        
        sendPing()
        timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: #selector(SimplePinger.sendPing), userInfo: nil, repeats: true)
        
        delegate?.startWithAddress(self, hostName: hostName)
    }
    
    func simplePing(pinger: SimplePing, didSendPacket: NSData) {
        assert(self.pinger == pinger)
        
        let sequenceNumber = SequenceNumber(didSendPacket)
        print(sequenceNumber, "sent")
        
        delegate?.sentPing(self, sequenceNumber: sequenceNumber)
    }

    func simplePing(pinger: SimplePing, didFailWithError error: NSError) {
        assert(self.pinger == pinger)
        
        let e = shortErrorFromError(error)
        
        print("failed: \(e)")
        
        timer?.invalidate()
        timer = nil
        self.pinger = nil
        
        delegate?.failWithError(self, error: e)
    }
    
    func simplePing(pinger: SimplePing, didFailToSendPacket packet: NSData, error: NSError) {
        assert(self.pinger == pinger)
        
        
    }
}

protocol SimplePingerDelegate {
    func startWithAddress(simplePinger: SimplePinger, hostName: String)
    func sentPing(simplePinger: SimplePinger, sequenceNumber: String)
    func failWithError(simplePinger: SimplePinger, error: String)
}