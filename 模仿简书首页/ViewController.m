//
//  ViewController.m
//  模仿简书首页
//
//  Created by xpchina2003 on 2017/4/21.
//  Copyright © 2017年 xpchina2003. All rights reserved.
//

#import "ViewController.h"
#import "TableHeaderView.h"
#import "TableSectionView.h"
#import "FirstTableView.h"
#import "SecondTableView.h"
#import "ThirdTableView.h"
#define kHeaderImgWidth 60

#define kSectionHeight 30
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong)UIImageView *headerView;
@property (nonatomic, strong)UIScrollView *contentView;
@property (nonatomic, strong)NSArray *titleArr;
@end
static NSString * const CELLINENTIFIER = @"CELLINENTIFIER";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleArr = @[@"动态", @"文章", @"更多"];
    
    // Do any additional setup after loading the view, typically from a nib.
    UITableView *bTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    bTableV.tableHeaderView = [[TableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 180)];
    bTableV.dataSource = self;
    bTableV.delegate = self;
    
    [self.view addSubview:bTableV];
    
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    _contentView.contentSize = CGSizeMake(SCREENWIDTH * 3, 0);
    _contentView.contentOffset = CGPointMake(0, 0);
    _contentView.pagingEnabled = YES;
    _contentView.delegate = self;
    [self layoutTableViews];
    
    [self configNavigationTitleView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TableSectionView *sectionView = [[TableSectionView alloc] initWithTitleArr:_titleArr sectionHeight:kSectionHeight];
    sectionView.clickBlock = ^(NSInteger btnTag) {
        [self.contentView setContentOffset:CGPointMake((btnTag - 100)*SCREENWIDTH, 0) animated:YES];
    };
    return sectionView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREENHEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return kSectionHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLINENTIFIER];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLINENTIFIER];
        [cell.contentView addSubview:self.contentView];
    }
    
    return cell;
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.contentView) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SCROLLEDNOTIFICATION" object:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.contentView) {
        
    }else if ([scrollView isKindOfClass:[UITableView class]]) {
        float temp = scrollView.contentOffset.y;
        float scale_t = 1.f;
        if (temp >= -64.f && temp <= -30.f) {
        }else if (temp < -64.f) {
            temp = -64.f;
            
        }else {
            temp = -30.f;
        }
        scale_t = fabsf(temp / 64);
        [self scaleAcimationWithScale:scale_t translate:(-temp-64) / 64 * 60]; //'60'控制headerView上升距离;单位不是pt
    }
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [self scaleAcimationWithScale:1.f translate:0];
}
- (void)layoutTableViews {
    for (int i = 0; i < _titleArr.count; i++) {
        UITableView *tableView;
        switch (i) {
            case 0:{
                tableView = [[FirstTableView alloc] initWithFrame:CGRectMake(i * SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT)];
            }
                break;
            case 1:{
                tableView = [[SecondTableView alloc] initWithFrame:CGRectMake(i * SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT)];
            }
                break;
            case 2:{
                tableView = [[ThirdTableView alloc] initWithFrame:CGRectMake(i * SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT)];
            }
                break;
            default:{
                tableView = [UITableView new];
            }
                break;
        }
        [_contentView addSubview:tableView];
    }
}

- (void)configNavigationTitleView {
    UIView *titleBackV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kHeaderImgWidth, 64 + kHeaderImgWidth/2.f)];
    //    titleBackV.backgroundColor = [UIColor orangeColor];
    
    self.headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, titleBackV.frame.size.height-kHeaderImgWidth, kHeaderImgWidth, kHeaderImgWidth)];
    _headerView.image = [UIImage imageNamed:@"header.JPG"];
    _headerView.layer.cornerRadius = kHeaderImgWidth/2.f;
    _headerView.layer.masksToBounds = YES;
    [titleBackV addSubview:_headerView];
    
    self.navigationItem.titleView = titleBackV;
}

- (void)scaleAcimationWithScale:(CGFloat)scale_t translate:(CGFloat)translate{
    CGAffineTransform t = CGAffineTransformMakeScale(scale_t, scale_t);
    t = CGAffineTransformTranslate(t, 0, translate);
    
    self.headerView.transform = t;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

