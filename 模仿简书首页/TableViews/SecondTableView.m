//
//  SecondTableView.m
//  简书-我的
//
//  Created by Liu Jiang on 2017/3/27.
//  Copyright © 2017年 Liu Jiang. All rights reserved.
//

#import "SecondTableView.h"
@interface SecondTableView ()<UITableViewDelegate, UITableViewDataSource>

@end
static NSString * const REUSEABLECELLIDENTIFIER = @"REUSEABLECELLIDENTIFIER";
@implementation SecondTableView
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
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEABLECELLIDENTIFIER];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:REUSEABLECELLIDENTIFIER];
        cell.textLabel.text = @"缺省的文字";
        cell.detailTextLabel.text = @"当你看到这行字时, 证明你还没有给我赋值";
    }
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
