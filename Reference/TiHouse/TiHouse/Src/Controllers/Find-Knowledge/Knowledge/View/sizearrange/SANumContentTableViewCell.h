//
//  SANumContentTableViewCell.h
//  TiHouse
//
//  Created by weilai on 2018/2/1.
//  Copyright © 2018年 Confused小伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KnowModeInfo.h"

@interface SANumContentTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^clickItemBlock)(KnowModeInfo * knowModeInfo);

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)refreshWithKnowModeInfo:(KnowModeInfo *)knowModeInfo;

+ (CGFloat)defaultHeight:(NSString *)content;

@end
