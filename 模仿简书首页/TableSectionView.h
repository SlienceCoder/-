//
//  TableSectionView.h
//  简书-我的
//
//  Created by Liu Jiang on 2017/3/27.
//  Copyright © 2017年 Liu Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 分区头 */
@interface TableSectionView : UIView
@property (nonatomic, copy)void(^clickBlock)(NSInteger btnTag);

- (instancetype)initWithTitleArr:(NSArray<NSString *> *)titleArr sectionHeight:(CGFloat) sectionHeight;
@end
