//
//  NSString+URLEncoding.h
//  StellarHomeIOS
//
//  Created by 周奇天 on 2019/6/24.
//  Copyright © 2019 don. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

@interface NSString(URLEncoding)

+ (NSString *)URLEncodedString:(NSString *)unencodedString;

@end

//NS_ASSUME_NONNULL_END
