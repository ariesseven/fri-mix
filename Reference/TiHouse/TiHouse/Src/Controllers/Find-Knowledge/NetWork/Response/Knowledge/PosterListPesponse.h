//
//  PosterListPesponse.h
//  TiHouse
//
//  Created by weilai on 2018/1/30.
//  Copyright © 2018年 Confused小伟. All rights reserved.
//

#import "GBResponsePageInfo.h"
#import "KnowModeInfo.h"

@interface PosterListPesponse : GBResponsePageInfo

@property (nonatomic, strong) NSArray<GroupKnowModeInfo *> *data;

@end
