//
//  SimplePinger.swift
//  Ping
//
//  Created by Derek Bassett on 4/11/16.
//  Copyright © 2016 Two Cavemen LLC. All rights reserved.
//

import Foundation


enum PingerConnection : Character {
    case Unknown = "\u{1F47D}"
    case Sad = "\u{1F62D}"
    case Happy = "\u{1F600}"
}


/**
 * have to be derived off of NSObject because SimplePingDelegate is Object C object.
 */
@objc class SimplePinger : NSObject, SimplePingDelegate {
    var pinger: SimplePing?
    var timer: NSTimer?
    var delegate: SimplePingerDelegate?
    var hostName: String
    var state: PingerConnection = .Unknown
    
    init(hostName: String) {
        self.hostName = hostName
    }
    
    func start() {
        pinger = SimplePing(hostName: self.hostName)
        pinger?.delegate = self
        pinger?.start()
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        pinger = nil
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
        
        self.state = .Happy
        
        delegate?.sentPing(self, sequenceNumber: sequenceNumber)
    }

    func simplePing(pinger: SimplePing, didFailWithError error: NSError) {
        assert(self.pinger == pinger)
        
        let e = shortErrorFromError(error)
        
        print("failed: \(e)")
        
        self.state = .Sad
        
        delegate?.failWithError(self, error: e)
    }
    
    func simplePing(pinger: SimplePing, didFailToSendPacket packet: NSData, error: NSError) {
        assert(self.pinger == pinger)
        
        let e = shortErrorFromError(error)
        
        print("failed: \(e)")
        
        self.state = .Sad
        
        delegate?.failToSendPacket(self, error: e)
    }
}

protocol SimplePingerDelegate {
    func startWithAddress(simplePinger: SimplePinger, hostName: String)
    func sentPing(simplePinger: SimplePinger, sequenceNumber: String)
    func failWithError(simplePinger: SimplePinger, error: String)
    func failToSendPacket(simplePinger: SimplePinger, error: String)
}

