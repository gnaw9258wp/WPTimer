//
//  WPProxy.h
//  TestDemo
//
//  Created by wp on 2018/12/30.
//  Copyright © 2018年 wp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//NSProxy消息转发到真正的代理类
@interface WPProxy : NSProxy
@property (nonatomic,weak)id target;
@end

NS_ASSUME_NONNULL_END
