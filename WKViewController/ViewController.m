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
        NSLog(@"%@",_panView);
        [_tableView setContentOffset:CGPointMake(0, -400) animated:YES];

        [UIView animateWithDuration:0.3 animations:^{
            UIEdgeInsets edgeInset = UIEdgeInsetsMake(400, 0, 0, 0);
            _tableView.contentInset = edgeInset;
            [_tableView setContentOffset:CGPointMake(0, -400) animated:YES];
            [_tableView scrollsToTop];

            _panView.frame = CGRectMake(0, 0, self.view.frame.size.width, 360);
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
    UIEdgeInsets edgeInset = UIEdgeInsetsMake(400, 0, 0, 0);
    _tableView.contentInset = edgeInset;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = [self backViewForTableView];
//    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    
}

-(UIView *)backViewForTableView
{
    UIView * backView = [[UIView alloc] initWithFrame:self.view.bounds];
    _backImageView = [[UIImageView alloc] initWithFrame:backView.bounds];
    _backImageView.image = [UIImage imageNamed:@"bt_mymusic_time_bg_afternoon.jpg"];
    _panView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 360)];
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
    WKSectionView *sectionView = [[WKSectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
//    sectionView.backgroundColor = [UIColor whiteColor];
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
//    NSLog(@"contentOffsetY%g:",contentOffsetY);
    if (_hide) {
        return;
    }
    if (contentOffsetY >= -400)
    {
        _backImageView.frame = CGRectMake(0, -contentOffsetY-400, self.view.frame.size.width, self.view.frame.size.height);
//        _tableView.bounces = NO;
//        NSLog(@"%@",NSStringFromCGRect(_backImageView.frame));
        _tableView.showsVerticalScrollIndicator = YES;
    }
    else
    {
       
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = YES;
    }
    if (contentOffsetY <= -400)
    {
        if (!_hide) {
            _panView.frame = CGRectMake(0, contentOffsetY+400, self.view.frame.size.width, 360);
        }
    }
    else
    {
        _panView.frame = CGRectMake(0, 0, self.view.frame.size.width, 360);
    }
//    if (condition) {
//        <#statements#>
//    }
//    NSLog(@"%@",NSStringFromUIEdgeInsets(scrollView.scrollIndicatorInsets));
    
}


//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
////    [scrollView scrollsToTop];
//
//}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat contentOffsetY = scrollView.contentOffset.y;

    if (contentOffsetY < -430) {
        if (!_hide) {
            _hide = YES;

        [UIView animateWithDuration:0.3 animations:^{
                NSLog(@"%@",_panView);
//                                _tableView.contentOffset = CGPointMake(0, -self.view.frame.size.height);
                UIEdgeInsets edgeInset = UIEdgeInsetsMake(self.view.frame.size.height, 0, 0, 0);
                _tableView.contentInset = edgeInset;

                [_tableView scrollRectToVisible:CGRectMake(0, -400, self.view.frame.size.width, -300) animated:YES];

                
                _panView.frame = CGRectMake(0, -415, self.view.frame.size.width, 360);
            } completion:^(BOOL finished) {
                [self presentViewController:[[TestViewCotroller alloc] init] animated:NO completion:nil];
                _panView.hidden = YES;
//                [scrollView scrollsToTop];


            }];
           
            [scrollView setContentOffset:CGPointMake(0, -self.view.frame.size.height) animated:YES];

        }
        return;
    }
    else
    {
       

    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
