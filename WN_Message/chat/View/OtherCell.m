//
//  OtherCell.m
//  WN_Message
//
//  Created by Way_Lone on 16/6/23.
//  Copyright © 2016年 Way_Lone. All rights reserved.
//

#import "OtherCell.h"
@interface OtherCell()
@property (weak, nonatomic) IBOutlet UIImageView *otherPoam;

@end
@implementation OtherCell

- (void)awakeFromNib {

    //other气泡
    UIImage *clipImage = [UIImage imageNamed:@"STextNodeBkg"];
    clipImage = [clipImage resizableImageWithCapInsets:UIEdgeInsetsMake(28, 13, 18, 13) resizingMode:UIImageResizingModeStretch];
    self.otherPoam.image = clipImage;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
