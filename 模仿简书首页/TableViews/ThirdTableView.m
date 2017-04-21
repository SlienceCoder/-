//
//  ThirdTableView.m
//  简书-我的
//
//  Created by Liu Jiang on 2017/3/27.
//  Copyright © 2017年 Liu Jiang. All rights reserved.
//

#import "ThirdTableView.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SectionZeroHeight 70
#define SectionOneHeight 50
#define kTitleLabImgSpacing 10
@interface ThirdTableView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)NSArray *sectionZeroImgArr;
@property (nonatomic, strong)NSArray *sectionOneImgArr;
@end
static NSString * const REUSEABLESECTIONZERO = @"REUSEABLESECTIONZERO";
static NSString * const REUSEABLESECTIONONE = @"REUSEABLESECTIONONE";
@implementation ThirdTableView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollEnabled = NO;
        self.dataSource = self;
        self.delegate = self;
        self.sectionOneImgArr = @[@"喜欢的文章", @"关注的专题", @"公司"];
        self.sectionZeroImgArr = @[@"文集", @"专题", @"关注", @"粉丝"];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? SectionZeroHeight : SectionOneHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEABLESECTIONZERO];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSEABLESECTIONZERO];
            [self layoutSubviewsWithSuperView:cell];
        }
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEABLESECTIONONE];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:REUSEABLESECTIONONE];
        }
        cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.sectionOneImgArr[indexPath.row] ofType:@"png"]];
        cell.imageView.image = [self scaleWithImage:cell.imageView.image];
        cell.textLabel.text = self.sectionOneImgArr[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14 weight:0.1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}
- (void)layoutSubviewsWithSuperView:(UITableViewCell *)cell {
    CGFloat btnWidth = SCREENWIDTH / self.sectionZeroImgArr.count;
    for (int i = 0; i < self.sectionZeroImgArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

        btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, SectionZeroHeight);
        [btn setImage:[UIImage imageNamed:_sectionZeroImgArr[i]] forState:UIControlStateNormal];
        [btn setTitle:_sectionZeroImgArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:[UIColor colorWithRed:231/255.0 green:129/255.0 blue:112/255.0 alpha:1] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        CGSize imgSize = [UIImage imageNamed:_sectionZeroImgArr[i]].size;
//        CGSize titleLabSize = [btn.titleLabel.text boundingRectWithSize:CGSizeMake(btnWidth, SectionZeroHeight) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        

        [btn setImageEdgeInsets:UIEdgeInsetsMake(7, (btnWidth-imgSize.width/2)/2, (SectionZeroHeight-7-imgSize.height/2), (btnWidth-imgSize.width/2)/2)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(30, -imgSize.width, 0, 0)];
        [cell.contentView addSubview:btn];
    }
}

- (void)handleClick:(UIButton *)sender {
    NSLog(@"Clicked %@", sender.titleLabel.text);
}
- (UIImage *)scaleWithImage:(UIImage *)image {
    CGSize size = CGSizeMake(25, 25);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
