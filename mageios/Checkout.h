//
//  Checkout.h
//  mageios
//
//  Created by KTPL - Mobile Development on 04/04/14.
//  Copyright (c) 2014 KTPL - Mobile Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checkout : NSObject

@property(nonatomic,retain)NSDictionary *response;

+ (Checkout *)getInstance;
- (void)savePayment:(NSDictionary *)data;
- (void)saveOrder:(NSDictionary *)data;
- (void)orderReview;

@end