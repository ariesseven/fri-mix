//
//  FindArtTableViewCell.h
//  TiHouse
//
//  Created by weilai on 2018/4/16.
//  Copyright © 2018年 Confused小伟. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FindAssemarcInfo.h"

@interface FindArtTableViewCell : UITableViewCell

- (void)refreshWithModel:(FindAssemarcInfo *)model;

@end
