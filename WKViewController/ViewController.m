//
//  ViewController.m
//  WKViewController
//
//  Created by macairwkcao on 15/10/30.
//  Copyright © 2015年 CWK. All rights reserved.
//

#import "ViewController.h"
#import "WKSectionView.h"
#import "TestViewCotroller.h"

#define TABLEVIEW_CONTENTINSET_TOP 400
#define PANVIEW_SIZE_HEIGHT TABLEVIEW_CONTENTINSET_TOP+10
#define TABLEVIEW_HIDE_CONTENTSETOFFY -TABLEVIEW_CONTENTINSET_TOP-30
#define DEVICE_SCREEN_HEIGHT self.view.frame.size.height
#define DEVICE_SCREEN_WIDTH self.view.frame.size.width
#define TABLEVIEW_HIDE_ANIMATIONS_NSTIMEINTERVAL 0.3



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UIImageView  *_backImageView;
    UITableView *_tableView;
    UIView *_panView;
    BOOL _hide;
}
@end

@implementation ViewController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_hide) {
        _panView.hidden = NO;
        _hide = NO;
        [_tableView setContentOffset:CGPointMake(0, -TABLEVIEW_CONTENTINSET_TOP) animated:YES];
        [UIView animateWithDuration:TABLEVIEW_HIDE_ANIMATIONS_NSTIMEINTERVAL animations:^{
            UIEdgeInsets edgeInset = UIEdgeInsetsMake(TABLEVIEW_CONTENTINSET_TOP, 0, 0, 0);
            _tableView.contentInset = edgeInset;
            [_tableView setContentOffset:CGPointMake(0, -TABLEVIEW_CONTENTINSET_TOP) animated:YES];
            [_tableView scrollsToTop];
            _panView.frame = CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, PANVIEW_SIZE_HEIGHT);
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self tableView];
    _hide = NO;
}

-(void)tableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UIEdgeInsets edgeInset = UIEdgeInsetsMake(TABLEVIEW_CONTENTINSET_TOP, 0, 0, 0);
    _tableView.contentInset = edgeInset;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = [self backViewForTableView];
    [self.view addSubview:_tableView];
    
}

-(UIView *)backViewForTableView
{
    UIView * backView = [[UIView alloc] initWithFrame:self.view.bounds];
    _backImageView = [[UIImageView alloc] initWithFrame:backView.bounds];
    _backImageView.image = [UIImage imageNamed:@"bt_mymusic_time_bg_afternoon.jpg"];
    _panView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, PANVIEW_SIZE_HEIGHT)];
    _panView.backgroundColor = [UIColor redColor];
    [_backImageView addSubview:_panView];
    [backView addSubview:_backImageView];
    return backView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试%ld",indexPath.row];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WKSectionView *sectionView = [[WKSectionView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, 120)];
    return sectionView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (_hide) {
        return;
    }
    if (contentOffsetY >= -TABLEVIEW_CONTENTINSET_TOP)
    {
        _backImageView.frame = CGRectMake(0, -contentOffsetY-TABLEVIEW_CONTENTINSET_TOP, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT);
        _tableView.showsVerticalScrollIndicator = YES;
    }
    else
    {
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = YES;
    }
    if (contentOffsetY <= -TABLEVIEW_CONTENTINSET_TOP)
    {
        if (!_hide) {
            _panView.frame = CGRectMake(0, contentOffsetY+TABLEVIEW_CONTENTINSET_TOP, DEVICE_SCREEN_WIDTH, PANVIEW_SIZE_HEIGHT);
        }
    }
    else
    {
        _panView.frame = CGRectMake(0, 0,DEVICE_SCREEN_WIDTH, PANVIEW_SIZE_HEIGHT);
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (contentOffsetY < TABLEVIEW_HIDE_CONTENTSETOFFY) {
        if (!_hide) {
            _hide = YES;
        [UIView animateWithDuration:TABLEVIEW_HIDE_ANIMATIONS_NSTIMEINTERVAL animations:^{
            UIEdgeInsets edgeInset = UIEdgeInsetsMake(DEVICE_SCREEN_HEIGHT, 0, 0, 0);
            _tableView.contentInset = edgeInset;

            [_tableView scrollRectToVisible:CGRectMake(0, -TABLEVIEW_CONTENTINSET_TOP, DEVICE_SCREEN_WIDTH, TABLEVIEW_CONTENTINSET_TOP/2) animated:YES];

            
            _panView.frame = CGRectMake(0, -PANVIEW_SIZE_HEIGHT,DEVICE_SCREEN_WIDTH, PANVIEW_SIZE_HEIGHT);
        } completion:^(BOOL finished) {
                [self presentViewController:[[TestViewCotroller alloc] init] animated:NO completion:nil];
                _panView.hidden = YES;
            }];
            [scrollView setContentOffset:CGPointMake(0, -DEVICE_SCREEN_HEIGHT) animated:YES];
        }
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
