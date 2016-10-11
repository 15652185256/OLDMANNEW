//
//  AFNetworkManager.m
//  OLDMAN
//
//  Created by 赵晓东 on 16/9/28.
//  Copyright © 2016年 ZXD. All rights reserved.
//

#import "AFNetworkManager.h"

@implementation AFNetworkManager
//AFNetwork 单列
static AFHTTPSessionManager * manager ;
static AFURLSessionManager * urlsession ;

+(AFHTTPSessionManager *)sharedHTTPSession
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10;
    });
    return manager;
}

+(AFURLSessionManager *)sharedURLSession
{
    static dispatch_once_t onceToken2;
    dispatch_once(&onceToken2, ^{
        urlsession = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    });
    return urlsession;
}
@end
