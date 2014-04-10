//
//  CartViewController.h
//  mageios
//
//  Created by KTPL - Mobile Development on 10/03/14.
//  Copyright (c) 2014 KTPL - Mobile Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CartViewController : UITableViewController <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet MBProgressHUD *loading;

- (IBAction)showCheckoutOptions:(id)sender;
@end