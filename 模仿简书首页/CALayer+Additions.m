//
//  CALayer+Additions.m
//  简书-我的
//
//  Created by Liu Jiang on 2017/3/27.
//  Copyright © 2017年 Liu Jiang. All rights reserved.
//

#import "CALayer+Additions.h"

@implementation CALayer (Additions)

- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
@end
