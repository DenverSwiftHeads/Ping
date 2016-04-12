//
//  Network.h
//  Ping
//
//  Created by Derek Bassett on 3/26/16.
//  Copyright © 2016 Two Cavemen LLC. All rights reserved.
//

#ifndef Network_h
#define Network_h

NS_ASSUME_NONNULL_BEGIN

NSString * DisplayAddressForAddress(NSData * address);

NSString * shortErrorFromError(NSError * error);

NSString * SequenceNumber(NSData * packet);

NS_ASSUME_NONNULL_END

#endif /* Network_h */
