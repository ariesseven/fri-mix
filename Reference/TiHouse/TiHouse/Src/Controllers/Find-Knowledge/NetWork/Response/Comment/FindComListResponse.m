//
//  FindComListResponse.m
//  TiHouse
//
//  Created by weilai on 2018/2/5.
//  Copyright © 2018年 Confused小伟. All rights reserved.
//

#import "FindComListResponse.h"

@implementation FindComListResponse

+ (NSDictionary *)bridgeClassAndArray {
    
    return @{@"data":[FindAssemarcCommentInfo class]};
}


- (NSArray *)onePageData {
    
    return self.data;
}


@end
