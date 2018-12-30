//
//  WPProxy.m
//  TestDemo
//
//  Created by wp on 2018/12/30.
//  Copyright © 2018年 wp. All rights reserved.
//

#import "WPProxy.h"

@implementation WPProxy
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    //获得target里面sel的方法签名
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    //转发给自己进行处理
    [invocation setTarget:self.target];
    [invocation invoke];
}
@end
