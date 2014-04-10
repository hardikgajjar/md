//
//  Checkout.m
//  mageios
//
//  Created by KTPL - Mobile Development on 04/04/14.
//  Copyright (c) 2014 KTPL - Mobile Development. All rights reserved.
//

#import "Checkout.h"
#import "Service.h"
#import "XMLDictionary.h"
#import "Core.h"

@implementation Checkout

static Checkout *instance =nil;

+(Checkout *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [Checkout new];
        }
    }
    return instance;
}

- (void)savePayment:(NSDictionary *)data
{
    Service *service = [Service getInstance];
    
    // initialize variables
    NSString *url = [[NSString alloc] initWithFormat:@"index.php/xmlconnect/checkout/savePayment"];
    
    // save payment method
    
    NSString *save_payment_url = [service.base_url stringByAppendingString:url];
    NSURL *URL = [NSURL URLWithString:save_payment_url];
    
    // prepare request with post data
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[Core encodeDictionary:data]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *save_payment = [session dataTaskWithRequest:request
                                                            completionHandler:
                                                  ^(NSData *remoteData, NSURLResponse *response, NSError *error) {
                                                      
                                                      // fire request complete event
                                                      [[NSNotificationCenter defaultCenter]
                                                       postNotificationName:@"requestCompletedNotification"
                                                       object:self];
                                                      
                                                      NSDictionary *res = [NSDictionary dictionaryWithXMLData:remoteData];

                                                      if ([[res valueForKey:@"status"] isEqualToString:@"success"]) {
                                                          
                                                          // store response
                                                          self.response = res;
                                                          
                                                          // fire event
                                                          [[NSNotificationCenter defaultCenter]
                                                           postNotificationName:@"paymentMethodSavedNotification"
                                                           object:self];
                                                          
                                                      } else if([[res valueForKey:@"status"] isEqualToString:@"error"]) {
                                                          [self performSelectorOnMainThread:@selector(showAlertWithErrorMessage:) withObject:[res valueForKey:@"text"] waitUntilDone:NO];
                                                      } else {
                                                          NSLog(@"%@", res);
                                                          [self performSelectorOnMainThread:@selector(showAlertWithErrorMessage:) withObject:nil waitUntilDone:NO];
                                                      }
                                                      
                                                  }];
    
    [save_payment resume];
}

- (void)saveOrder:(NSDictionary *)data
{
    Service *service = [Service getInstance];
    
    // initialize variables
    NSString *url = [[NSString alloc] initWithFormat:@"index.php/xmlconnect/checkout/saveOrder"];
    
    // save order
    
    NSString *save_order_url = [service.base_url stringByAppendingString:url];
    NSURL *URL = [NSURL URLWithString:save_order_url];
    
    // prepare request with post data
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[Core encodeDictionary:data]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *save_order = [session dataTaskWithRequest:request
                                                    completionHandler:
                                          ^(NSData *remoteData, NSURLResponse *response, NSError *error) {
                                              
                                              // fire request complete event
                                              [[NSNotificationCenter defaultCenter]
                                               postNotificationName:@"requestCompletedNotification"
                                               object:self];
                                              
                                              NSDictionary *res = [NSDictionary dictionaryWithXMLData:remoteData];

                                              if ([[res valueForKey:@"status"] isEqualToString:@"success"]) {
                                                  
                                                  // store response
                                                  self.response = res;
                                                  
                                                  // fire event
                                                  [[NSNotificationCenter defaultCenter]
                                                   postNotificationName:@"orderSavedNotification"
                                                   object:self];
                                                  
                                              } else if([[res valueForKey:@"status"] isEqualToString:@"error"]) {
                                                  [self performSelectorOnMainThread:@selector(showAlertWithErrorMessage:) withObject:[res valueForKey:@"text"] waitUntilDone:NO];
                                              } else {
                                                  NSLog(@"%@", res);
                                                  [self performSelectorOnMainThread:@selector(showAlertWithErrorMessage:) withObject:nil waitUntilDone:NO];
                                              }
                                              
                                          }];
    
    [save_order resume];
}

- (void)orderReview
{
    Service *service = [Service getInstance];
    
    // initialize variables
    NSString *url = [[NSString alloc] initWithFormat:@"index.php/xmlconnect/checkout/orderReview"];
    
    // get review order details
    
    NSString *review_order_url = [service.base_url stringByAppendingString:url];
    NSURL *URL = [NSURL URLWithString:review_order_url];
    
    // prepare request with post data
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *review_order = [session dataTaskWithRequest:request
                                                    completionHandler:
                                          ^(NSData *remoteData, NSURLResponse *response, NSError *error) {
                                              
                                              // fire request complete event
                                              [[NSNotificationCenter defaultCenter]
                                               postNotificationName:@"requestCompletedNotification"
                                               object:self];
                                              
                                              NSDictionary *res = [NSDictionary dictionaryWithXMLData:remoteData];
                                              NSLog(@"%@", res);
                                              if ([res valueForKey:@"products"] != nil) {
                                                  
                                                  // store response
                                                  self.response = res;
                                                  
                                                  // fire event
                                                  [[NSNotificationCenter defaultCenter]
                                                   postNotificationName:@"orderReviewDataLoadedNotification"
                                                   object:self];
                                                  
                                              } else {
                                                  NSLog(@"%@", res);
                                                  [self performSelectorOnMainThread:@selector(showAlertWithErrorMessage:) withObject:nil waitUntilDone:NO];
                                              }
                                              
                                          }];
    
    [review_order resume];
}

- (void)showAlertWithErrorMessage:(NSString *)message
{
    if (message == nil) message = @"Unable to login.";
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"An Error Occured"
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"Dismiss"
                          otherButtonTitles:nil];
    
    [alert show];
}

@end