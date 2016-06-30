//
//  ChatViewController.m
//  WN_Message
//
//  Created by Way_Lone on 16/6/22.
//  Copyright © 2016年 Way_Lone. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatTool.h"
#import "OtherCell.h"
#import "MeCell.h"
@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *ChatInput;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstant;

@property (weak, nonatomic) IBOutlet UITextView *chatTextView;

@property (strong, nonatomic) NSMutableArray *msgs;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstant;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation ChatViewController

#pragma mark view
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置颜色
    [self setUpColor];
    //九切片处理气泡等图片
    [self clipImage];
    //设置tableView
    [self setUpTableView];
    //设置chatTextView
    [self setUpChatTextView];
}
/**
 *  设置颜色
 */
-(void)setUpColor{
    if (self.backgroundColor) {
        self.view.backgroundColor = self.backgroundColor;
    }else{
        self.view.backgroundColor = [UIColor colorWithRed:0.974 green:0.853 blue:1.000 alpha:1.000];
    }
    if (self.bottomViewColor){
        self.bottomView.backgroundColor = self.bottomViewColor;
    }
}
/**
 * 设置chatTextView
 */
-(void)setUpChatTextView{
    self.chatTextView.delegate = self;
    self.chatTextView.showsVerticalScrollIndicator = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //根据顶部导航条和状态栏调整界面位置
    [self autoResizeView];
    //针对消息加KVO观察
    [[ChatTool sharedChatTool] addObserver:self forKeyPath:@"msgCount" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    //键盘KVO
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //移除KVO
    [[ChatTool sharedChatTool] removeObserver:self forKeyPath:@"msgCount"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
/**设置tableView */
-(void)setUpTableView{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = false;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 87;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (self.backgroundColor) {
        self.tableView.backgroundColor = self.backgroundColor;
    }else{
        self.tableView.backgroundColor = [UIColor colorWithRed:0.974 green:0.853 blue:1.000 alpha:1.000];
    }
}
/**键盘开启*/
-(void)openKeyboard:(NSNotification*)notification{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    self.bottomConstant.constant = keyboardFrame.size.height;
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    }];
    
}
/**键盘关闭*/
-(void)closeKeyboard:(NSNotification*)notification{
    
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    self.bottomConstant.constant = 0;
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    }];
    
}
/**KVO观察*/
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"msgCount"]) {
        self.msgs = [[ChatTool sharedChatTool] getChatMessages];
        //        self.filesArray = change[@"new"];
        [self.tableView reloadData];
    }
}
/**
 * 根据顶部导航条和状态栏调整界面位置
 */
-(void)autoResizeView{
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat naviBarHeight = self.navigationController.navigationBar.frame.size.height;
    self.topConstant.constant = statusBarHeight + naviBarHeight;
}
/**
 *  九切片处理气泡图片
 */
-(void)clipImage{
    //输入框
    UIImage *clipImage = [UIImage imageNamed:@"ChatInput"];
    clipImage = [clipImage resizableImageWithCapInsets:UIEdgeInsetsMake(5, 9, 5, 9) resizingMode:UIImageResizingModeStretch];
    self.ChatInput.image = clipImage;
    

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  强制竖屏
 */
-(BOOL)shouldAutorotate{
    return YES;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}
#pragma mark UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.msgs.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    ChatMsg *msg = self.msgs[indexPath.row];
    if (msg.isFromOther) {
        OtherCell *otherCell = [tableView dequeueReusableCellWithIdentifier:@"otherCell"];
        if (!otherCell) {
            otherCell = (OtherCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"OtherCell" owner:self options:nil]  lastObject];
        }
        
        if (msg.msgHeadImage) {
            otherCell.headImageView.image = msg.msgHeadImage;
        }else{
            otherCell.headImageView.image = [UIImage imageNamed:@"defaultHeadImage"];
        }
        if (msg.msgPeople) {
            otherCell.nameLabel.text = msg.msgPeople;
        }else{
            otherCell.nameLabel.text = @"other";
        }
        otherCell.msgLabel.text = msg.msgContent;
        otherCell.dateLabel.text = [formatter stringFromDate:msg.msgDate];
        if (self.backgroundColor) {
            otherCell.backgroundColor = self.backgroundColor;
        }
        otherCell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPress.delegate = self;
        [otherCell addGestureRecognizer:longPress];
        return otherCell;
        
    }else{
        MeCell *meCell = [tableView dequeueReusableCellWithIdentifier:@"meCell"];
        if (!meCell) {
            meCell = (MeCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"MeCell" owner:self options:nil]  lastObject];
        }
        
        if (msg.msgHeadImage) {
            meCell.headImageView.image = msg.msgHeadImage;
        }else{
            meCell.headImageView.image = [UIImage imageNamed:@"defaultHeadImage"];
        }
        if (msg.msgPeople) {
            meCell.nameLabel.text = msg.msgPeople;
        }else{
            meCell.nameLabel.text = @"other";
        }
        meCell.msgLabel.text = msg.msgContent;
        meCell.dateLabel.text = [formatter stringFromDate:msg.msgDate];
        if (self.backgroundColor) {
            meCell.backgroundColor = self.backgroundColor;
        }
        meCell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPress.delegate = self;
        [meCell addGestureRecognizer:longPress];
        return meCell;
    }
    
}
/**长按手势 */
-(void)longPress:(UILongPressGestureRecognizer*)sender{
    
}
/**防止手势冲突 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    return NO;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}
#pragma mark UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //回车键执行操作
    if ([text isEqualToString:@"\n"]) {
//        [[ChatTool sharedChatTool] sendChatMessage];
        ChatMsg *chatMsg = [ChatMsg new];
        chatMsg.msgContent = self.chatTextView.text;
        [[ChatTool sharedChatTool]addChatMsg:chatMsg];
        self.chatTextView.text = @"";
        
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
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
- (NSMutableArray *)msgs {
	if(_msgs == nil) {
		_msgs = [[NSMutableArray alloc] init];
        
        self.msgs = [[ChatTool sharedChatTool] getChatMessages];
//        ChatMsg *msg1 = [[ChatMsg alloc]init];
//        msg1.msgContent = @"fdsafdsafdasfdsafdsafdsafdsafdsafdsasafdsafdsafdsafdsafdsasafdsafdsafdsafdsafdsasafdsafdsafdsafdsafdsasafdsafdsafdsafdsafdsasafdsafdsafdsafdsafdsasafdsafdsafdsafdsafdsasafdsafdsafdsafdsafdsa";
//        msg1.isFromOther = NO;
//        ChatMsg *msg2 = [[ChatMsg alloc]init];
//        msg2.msgContent = @"fdsafdsafdasfdsafdsafdsafdsafdsafdsafsafdsafdsafdsafsafdsafdsafdsafsafdsafdsafdsafdafdsafdsa";
//        msg2.isFromOther = YES;
//        [self.msgs addObject:msg1];
//        [self.msgs addObject:msg2];
//        [self.msgs addObjectsFromArray:[[ChatTool sharedChatTool] getChatMessages]];
    }
	return _msgs;
}

@end
