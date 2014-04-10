//
//  PaymentViewController.h
//  mageios
//
//  Created by KTPL - Mobile Development on 28/03/14.
//  Copyright (c) 2014 KTPL - Mobile Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "PaypalViewController.h"

@interface PaymentViewController : UITableViewController <PaypalViewDelegate>

@property (weak, nonatomic) IBOutlet MBProgressHUD *loading;

@end