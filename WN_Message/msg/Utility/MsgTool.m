//
//  MsgTool.m
//  WN_Message
//
//  Created by Way_Lone on 16/6/23.
//  Copyright © 2016年 Way_Lone. All rights reserved.
//

#import "MsgTool.h"
static MsgTool *msgTool;
@interface MsgTool()
@property(nonatomic,strong) NSMutableArray *messages;
@property(nonatomic,assign) NSUInteger numOfNewMsg;

@end
@implementation MsgTool
+(instancetype)sharedMsgTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!msgTool) {
            msgTool = [[MsgTool alloc]init];
        }
    });
    return msgTool;
}
-(void)addMsg:(NSString *)msgStr{
    [self.messages addObject:msgStr];
}
-(NSArray *)getMessages{
    //在这里接收后台服务器代码
    return self.messages;
}

- (NSMutableArray *)messages {
	if(_messages == nil) {
		_messages = [[NSMutableArray alloc] init];
	}
	return _messages;
}

@end
