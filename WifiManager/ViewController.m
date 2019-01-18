//
//  ViewController.m
//  WifiManager
//
//  Created by Josh Wang on 1/16/19.
//  Copyright © 2019 Opendoor. All rights reserved.
//

#import "ViewController.h"
#import <NetworkExtension/NetworkExtension.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self updateViews];
   
    NSString *SSID = @"NotKnox2";
    NSString *passphrase = @"987654321";
    NEHotspotConfiguration *configuration = [[NEHotspotConfiguration alloc] initWithSSID:SSID
                                                                              passphrase:passphrase
                                                                                   isWEP:NO];
    [[NEHotspotConfigurationManager sharedManager] applyConfiguration:configuration
                                                    completionHandler:^(NSError * _Nullable error) {
                                                        if (error != nil) {
                                                            NSLog(@"nehotspot_error Error while configuring WiFi %@", error);
                                                        } else {
                                                            [self updateViews];
                                                        }
                                                    }];
    
}

- (void) updateViews{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSMutableDictionary *connections = [[NSMutableDictionary alloc] init];
    NSString *kSSID = (NSString *)kCNNetworkInfoKeySSID;
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        connections[ifnam] = info;
        if (info[kSSID]) {
            [self.NetworkNameLabel setText:info[kSSID]];
        }
    }
    [self.NetworkTextView setText:connections.description];
    
    // list out configured connections
    [[NEHotspotConfigurationManager sharedManager] getConfiguredSSIDsWithCompletionHandler:^(NSArray<NSString *> * _Nonnull configuredNetworks) {
        [self.ConfiguredNetworks setText:configuredNetworks.description];
    }];
}

// 70:2c:1f:40:51:7b


@end
