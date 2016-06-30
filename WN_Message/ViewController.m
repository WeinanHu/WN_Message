//
//  ViewController.m
//  WN_Message
//
//  Created by Way_Lone on 16/6/22.
//  Copyright © 2016年 Way_Lone. All rights reserved.
//

#import "ViewController.h"
#import "MsgViewController.h"
#import "ChatViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@property (weak, nonatomic) IBOutlet UILabel *chatLabel;
@property (weak, nonatomic) IBOutlet UIButton *msgButton;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;

@end

@implementation ViewController


#pragma mark button
- (IBAction)clickChatButton:(id)sender {
    
    ChatViewController *chatController = [[ChatViewController alloc]initWithNibName:@"ChatViewController" bundle:nil];
    [self pushController:chatController];

}
- (IBAction)clickMsgButton:(id)sender {
    MsgViewController *msgController = [[MsgViewController alloc]initWithNibName:@"MsgViewController" bundle:nil];

    [self pushController:msgController];
}
/**
 *  推出控制器，如果有导航控制器，则push,如果没有，则present。
 *
 *  @param sender 控制器对象
 */
-(void)pushController:(id)sender{
    if (self.navigationController) {
        [self.navigationController pushViewController:sender animated:YES];
    }else{
        [self presentViewController:sender animated:YES completion:nil];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.msgLabel.text = [NSString stringWithFormat:@"您有%ld条新消息",[UIApplication sharedApplication].applicationIconBadgeNumber];
    self.chatLabel.text = [NSString stringWithFormat:@"您有%ld条新聊天消息",[UIApplication sharedApplication].applicationIconBadgeNumber];
    [[UIApplication sharedApplication] addObserver:self forKeyPath:@"applicationIconBadgeNumber" options:NSKeyValueObservingOptionOld context:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] removeObserver:self forKeyPath:@"applicationIconBadgeNumber"];
}
/**KVO观察*/
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"applicationIconBadgeNumber"]) {
        self.msgLabel.text = [NSString stringWithFormat:@"您有%ld条新消息",[UIApplication sharedApplication].applicationIconBadgeNumber+1];
        self.chatLabel.text = [NSString stringWithFormat:@"您有%ld条新聊天消息",[UIApplication sharedApplication].applicationIconBadgeNumber+1];
        //        self.filesArray = change[@"new"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
     
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
