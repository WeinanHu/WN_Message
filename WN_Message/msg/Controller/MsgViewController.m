//
//  MsgViewController.m
//  WN_Message
//
//  Created by Way_Lone on 16/6/22.
//  Copyright © 2016年 Way_Lone. All rights reserved.
//

#import "MsgViewController.h"
#import "MsgTool.h"
@interface MsgViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstant;
@property (strong, nonatomic) NSArray *msgs;

@end

@implementation MsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.backgroundColor) {
        self.view.backgroundColor = self.backgroundColor;
    }
    [self setUpTableView];
}
/**设置tableView */
-(void)setUpTableView{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = false;
    
    if (self.backgroundColor) {
        self.tableView.backgroundColor = self.backgroundColor;
    }else{
        self.tableView.backgroundColor = [UIColor colorWithRed:0.974 green:0.853 blue:1.000 alpha:1.000];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //根据顶部导航条和状态栏调整界面位置
    [self autoResizeView];
    [UIApplication sharedApplication].applicationIconBadgeNumber =  0;
}
/**
 * 根据顶部导航条和状态栏调整界面位置
 */
-(void)autoResizeView{
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat naviBarHeight = self.navigationController.navigationBar.frame.size.height;
    self.topConstant.constant = statusBarHeight + naviBarHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.msgs.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"msgCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"msgCell"];
    }
    
    cell.textLabel.text = self.msgs[indexPath.row];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark lazy load
- (NSArray *)msgs {
	if(_msgs == nil) {
		_msgs = [[MsgTool sharedMsgTool]getMessages];
	}
	return _msgs;
}

@end
