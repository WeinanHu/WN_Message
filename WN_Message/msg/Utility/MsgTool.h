//
//  MsgTool.h
//  WN_Message
//
//  Created by Way_Lone on 16/6/23.
//  Copyright © 2016年 Way_Lone. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MsgTool : NSObject
/**单例 */
+(instancetype)sharedMsgTool;
/**获取消息 */
-(NSArray*)getMessages;

@property(nonatomic,strong,readonly) NSMutableArray *messages;
@property(nonatomic,assign,readonly) NSUInteger numOfNewMsg;

-(void)addMsg:(NSString*)msgStr;
@end
