//
//  Person.m
//  demo2
//
//  Created by 林小文 on 16/1/23.
//  Copyright © 2016年 林小文. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (Person *)person{
    
    Person * p = [[Person alloc] init];
    
    p.name = @"name";
    
    return p;
    
}


@end
