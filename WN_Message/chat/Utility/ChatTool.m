//
//  ChatTool.m
//  WN_Message
//
//  Created by Way_Lone on 16/6/22.
//  Copyright © 2016年 Way_Lone. All rights reserved.
//

#import "ChatTool.h"
static ChatTool *chatTool;
@interface ChatTool()
@property(nonatomic,strong) NSMutableArray *chatMessages;
//@property(nonatomic,assign) NSUInteger numOfNewMsg;

@end
@implementation ChatTool
+(instancetype)sharedChatTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!chatTool) {
            chatTool = [[ChatTool alloc]init];
        }
    });
    return chatTool;
}
-(void)addChatMsg:(ChatMsg*)chatMsg{
    [self.chatMessages addObject:chatMsg];
    self.msgCount = self.chatMessages.count;
}
-(NSMutableArray<ChatMsg *> *)getChatMessages{
    //从后台获取消息数组，并遍历保存至消息模型类。
    
    //TODO: 这里写代码，存入下面的chatMsgs 数组。
    
    
    return self.chatMessages;
}
-(void)sendChatMessage{
    //TODO:这里写代码，转化成后台数据，发送给服务器
}


- (NSMutableArray *)chatMessages {
	if(_chatMessages == nil) {
		_chatMessages = [[NSMutableArray alloc] init];
	}
	return _chatMessages;
}

@end
