//
//  FirstTableView.m
//  简书-我的
//
//  Created by Liu Jiang on 2017/3/27.
//  Copyright © 2017年 Liu Jiang. All rights reserved.
//

#import "FirstTableView.h"
@interface FirstTableView ()<UITableViewDelegate, UITableViewDataSource>

@end
static NSString * const REUSEABLECELLIDENTIFIER = @"REUSEABLECELLIDENTIFIER";
@implementation FirstTableView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollEnabled = NO;
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEABLECELLIDENTIFIER];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:REUSEABLECELLIDENTIFIER];
    }
    cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"header" ofType:@"JPG"]];
    cell.textLabel.text = @"苹果橘子香蕉梨";
    cell.detailTextLabel.text = @"🍎🍊🍌🍐";
    return cell;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
