//
//  NSString+URLEncoding.m
//  StellarHomeIOS
//
//  Created by 周奇天 on 2019/6/24.
//  Copyright © 2019 don. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString(URLEncoding)

+ (NSString *)URLEncodedString:(NSString *)unencodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

@end
