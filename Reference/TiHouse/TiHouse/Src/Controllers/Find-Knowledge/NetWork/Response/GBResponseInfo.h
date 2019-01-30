//
//  GBResponseInfo.h
//  GB_Football
//
//  Created by weilai on 16/7/7.
//  Copyright © 2016年 Go Brother. All rights reserved.
//

#import "YAHDataResponseInfo.h"
#import "GBRespDefine.h"

@interface GBResponseInfo : YAHDataResponseInfo

@property (nonatomic, assign) NSInteger is;
@property (nonatomic, strong) NSString *msg;

/**
 * @brief 重置数据
 */
- (void)resetResponseInfo;

@end
