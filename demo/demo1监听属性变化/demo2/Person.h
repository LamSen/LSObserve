//
//  Person.h
//  demo2
//
//  Created by 林小文 on 16/1/23.
//  Copyright © 2016年 林小文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

/// 名字
@property (strong, nonatomic) NSString *name;

+ (Person *)person;

@end
