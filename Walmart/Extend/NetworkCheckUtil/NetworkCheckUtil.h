//
//  NetworkCheckUtil.h
//  Login_send
//
//  Created by hao jiao on 10-11-23.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SystemConfiguration/SCNetworkReachability.h"
#include <netinet/in.h>
#include <netdb.h>
#include <sys/socket.h>
#include <arpa/inet.h>


@interface NetworkCheckUtil : NSObject {
	
}

+ (NSString*)getIpAddressForHost:(NSString*) theHost;
+ (BOOL)canConnectToNetwork;
+ (BOOL)canConnectToServer:(NSString *)hostName;

@end
