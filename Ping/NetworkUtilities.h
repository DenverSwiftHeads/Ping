//
//  Network.h
//  Ping
//
//  Created by Derek Bassett on 3/26/16.
//  Copyright © 2016 Two Cavemen LLC. All rights reserved.
//

#ifndef Network_h
#define Network_h

#include <sys/socket.h>
#include <netdb.h>

#pragma mark * Utilities

static NSString * DisplayAddressForAddress(NSData * address)
// Returns a dotted decimal string for the specified address (a (struct sockaddr)
// within the address NSData).
{
    int         err;
    NSString *  result;
    char        hostStr[NI_MAXHOST];
    
    result = nil;
    
    if (address != nil) {
        err = getnameinfo([address bytes], (socklen_t) [address length], hostStr, sizeof(hostStr), NULL, 0, NI_NUMERICHOST);
        if (err == 0) {
            result = [NSString stringWithCString:hostStr encoding:NSASCIIStringEncoding];
            assert(result != nil);
        }
    }
    
    return result;
}

static NSString * SequenceNumber(NSData * packet)
// Return the sequence number
{
    unsigned int sequenceNumber = (unsigned int) OSSwapBigToHostInt16(((const ICMPHeader *)[packet bytes])->sequenceNumber);
    return [NSString stringWithFormat: @"%u", sequenceNumber];
}

#endif /* Network_h */
