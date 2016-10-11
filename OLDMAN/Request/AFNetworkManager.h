//
//  AFNetworkManager.h
//  OLDMAN
//
//  Created by 赵晓东 on 16/9/28.
//  Copyright © 2016年 ZXD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNetworkManager : NSObject

+(AFHTTPSessionManager *)sharedHTTPSession;

+(AFURLSessionManager *)sharedURLSession;

@end
