//
//  Constants.m
//
//  Game805Stats
//
//  Created by Shenll-Mac2 on 13/06/16.
//  Copyright © 2016 Shenll. All rights reserved.
//

#import "Constants.h"

@implementation Constants


+(void)printLogKey:(NSString *)printKey printValue:(id)printingValue
{
    if([IS_DEBUG_MODE isEqualToString:@"0"]){
        NSLog(@"SHENLL LOG - %@ : %@",printKey,printingValue);
    }
    NSLog(@"SHENLL LOG - %@ : %@",printKey,printingValue);

   
}

@end
