//
//  BNaviSoundManager+Patch.h
//  DHETC
//
//  Created by 张文龙 on 16/9/21.
//  Copyright © 2016年 yujiuyin. All rights reserved.
//

//百度地图调用[[BNCoreServices GetInstance] stopServices];导致崩溃临时修复方案
@interface BNaviSoundManager:NSObject
@end

@interface BNaviSoundManager (Patch)
-(BOOL)unInitTTSPlayer;
@end
