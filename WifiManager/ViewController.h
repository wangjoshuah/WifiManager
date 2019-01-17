//
//  ViewController.h
//  WifiManager
//
//  Created by Josh Wang on 1/16/19.
//  Copyright © 2019 Opendoor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *NetworkNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *NetworkTextView;
@property (weak, nonatomic) IBOutlet UITextView *ConfiguredNetworks;

@end

