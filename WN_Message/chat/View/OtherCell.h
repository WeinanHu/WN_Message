//
//  OtherCell.h
//  WN_Message
//
//  Created by Way_Lone on 16/6/23.
//  Copyright © 2016年 Way_Lone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
