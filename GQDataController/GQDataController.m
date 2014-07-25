//
//  GQDataController.m
//  GQDataController
//
//  Created by 钱国强 on 14-5-25.
//  Copyright (c) 2014年 Qian GuoQiang. All rights reserved.
//

#import "GQDataController.h"
#import <AFNetworking/AFNetworking.h>

@interface GQDataController ()

@property (nonatomic, strong) AFHTTPRequestOperation *httpOperation;

@end

@implementation GQDataController

+ (instancetype)sharedDataController
{
    static dispatch_once_t onceToken;
    static NSMutableDictionary *sharedInstances = nil;
    static NSLock *sharedLock = nil;
    
    dispatch_once(&onceToken, ^{
        sharedInstances = [NSMutableDictionary dictionary];
        sharedLock = [[NSLock alloc] init];
    });
    
    NSString *keyName = NSStringFromClass([self class]);
    GQDataController *aController = nil;
    
    if ([sharedLock tryLock]) {
        aController = [sharedInstances objectForKey:keyName];
        
        if (aController == nil) {
            aController = [[self alloc] init];
            
            [sharedInstances setObject:aController
                                forKey:keyName];
        }
        
        [sharedLock unlock];
    }
    
    return aController;
}

+ (void)requestWithURLString:(NSString *)URLString completion:(void (^)(NSString *content))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:URLString
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (completion) {
                 completion([operation responseString]);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}


- (void)requestWithParams:(NSDictionary *)params completion:(void (^)(NSError *error))completion
{
    
}

- (NSURLRequest *)httpRequest
{
    return self.httpOperation.request;
}

- (NSHTTPURLResponse *)httpResponse
{
    return self.httpOperation.response;
}

#pragma mark - Abstract method

- (NSString *)requestMethod
{
    return @"GET";
}

- (NSArray *)requestURL
{
    return nil;
}

- (BOOL)parseContent:(NSString *)content
{
    return NO;
}

#pragma mark - UITableViewDataSource

@end
