//
//  ChatMsg.h
//  WN_Message
//
//  Created by Way_Lone on 16/6/22.
//  Copyright © 2016年 Way_Lone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ChatMsg : NSObject
/**是否是从别人那接受到的消息 */
@property(nonatomic,assign) BOOL isFromOther;
/**消息内容 */
@property(nonatomic,strong) NSString *msgContent;
/**消息人头像 */
@property(nonatomic,strong) UIImage *msgHeadImage;
/**消息人名 */
@property(nonatomic,strong) NSString *msgPeople;
/**消息时间 */
@property(nonatomic,strong) NSDate *msgDate;

@end
