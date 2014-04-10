//
//  OrderReviewViewController.h
//  mageios
//
//  Created by KTPL - Mobile Development on 07/04/14.
//  Copyright (c) 2014 KTPL - Mobile Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface OrderReviewViewController : UITableViewController

@property (weak, nonatomic) IBOutlet MBProgressHUD *loading;

- (IBAction)placeOrder:(id)sender;

@end
