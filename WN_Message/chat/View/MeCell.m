//
//  MeCell.m
//  WN_Message
//
//  Created by Way_Lone on 16/6/23.
//  Copyright © 2016年 Way_Lone. All rights reserved.
//

#import "MeCell.h"
@interface MeCell()
@property (weak, nonatomic) IBOutlet UIImageView *mePoam;

@end
@implementation MeCell

- (void)awakeFromNib {
    // Initialization code
    //me气泡
    UIImage *clipImage = [UIImage imageNamed:@"RTextNodeBkg"];
    clipImage = [clipImage resizableImageWithCapInsets:UIEdgeInsetsMake(28, 13, 18, 13) resizingMode:UIImageResizingModeStretch];
    self.mePoam.image = clipImage;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
