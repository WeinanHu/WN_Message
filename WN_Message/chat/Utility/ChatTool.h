//
//  ChatTool.h
//  WN_Message
//
//  Created by Way_Lone on 16/6/22.
//  Copyright © 2016年 Way_Lone. All rights reserved.
//

/** 在这个工具类中进行聊天后台数据的发送和接受，与后台的对接要修改这个文件
 */
#import <Foundation/Foundation.h>
#import "ChatMsg.h"
@interface ChatTool : NSObject
/**单例 */
+(instancetype)sharedChatTool;
/**获取聊天消息 */
-(NSMutableArray<ChatMsg*>*)getChatMessages;
/**发送聊天消息 */
-(void)sendChatMessage;
-(void)addChatMsg:(ChatMsg*)chatMsg;

@property(nonatomic,strong,readonly) NSMutableArray *chatMessages;
@property(nonatomic,assign,) NSUInteger numOfNewMsg;
@property(nonatomic,assign) NSUInteger msgCount;
@end
