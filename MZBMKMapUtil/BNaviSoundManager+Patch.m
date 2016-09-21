//
//  BNaviSoundManager+Patch.m
//  DHETC
//
//  Created by 张文龙 on 16/9/21.
//  Copyright © 2016年 yujiuyin. All rights reserved.
//

#import "BNaviSoundManager+Patch.h"

@implementation BNaviSoundManager (Patch)
- (BOOL)unInitTTSPlayer{
    return YES;
}
@end
