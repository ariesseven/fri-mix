//
//  main.m
//  Mix
//
//  Created by ChenJie on 2019/1/20.
//  Copyright © 2019 ChenJie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model/MixObject.h"
#import "Model/MixFile.h"
#import "Strategy/MixFileStrategy.h"
#import "Strategy/MixClassFileStrategy.h"
#import "Strategy/MixObjectStrategy.h"
#import "Strategy/MixMainStrategy.h"
#import "Strategy/MixReferenceStrategy.h"
#import "Strategy/MixMethodStrategy.h"
#import "Config/MixConfig.h"
#import "Strategy/file/MixFileNameStrategy.h"
#import "Strategy/protocol/MixProtocolStrategy.h"
#import "MixYAHCategoryStrategy.h"
#import "Strategy/category/MixYAHCategoryStrategy.h"
#import "Strategy/MixStringStrategy.h"

#import "MixDefine.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        char a[1000];
        MixLog(@"请输入mix.plist文件路径\n");
        scanf("%s",a);
        NSString * path = [NSString stringWithFormat:@"%s", a];
        [MixConfig sharedSingleton].mixPlistPath = path;
        
        NSString * referencePath = [MixConfig sharedSingleton].referencePath;
        NSString * rootPath = [MixConfig sharedSingleton].rootPath;
        NSString * copyPath = [NSString stringWithFormat:@"%@_mix",rootPath];
        
        if (!referencePath || !rootPath) {
            MixLog(@"请检查配置\n");
            return 0;
        }


        MixLog(@"拷贝文件中..\n");
        BOOL isSuccess = [MixFileStrategy copyItemAtPath:rootPath toPath:copyPath overwrite:YES error:nil];
        if (!isSuccess) {
            MixLog(@"拷贝文件失败\n");
            return 0;
        }
        MixLog(@"拷贝文件成功\n");
        MixLog(@"获取替换对象\n");

        NSArray <MixObject*>* referenceObjects = [MixObjectStrategy objectsForKey:@"mix_reference"];
        if (!referenceObjects) {
            referenceObjects = [MixObjectStrategy objectsWithPath:referencePath];
            [MixObjectStrategy saveObjects:referenceObjects key:@"mix_reference"];
        }
        
        MixLog(@"获取需要被替换对象\n");
        NSArray <MixObject*>* copyObjects = [MixObjectStrategy objectsWithPath:copyPath saveConfig:YES];
        
        MixLog(@"获取替换类名\n");
        NSArray <NSString *>* classNames = [MixReferenceStrategy classNamesWithObjects:referenceObjects];
        MixLog(@"开始替换类名\n");
        [MixMainStrategy replaceClassName:copyObjects referenceClassNames:classNames];
        MixLog(@"结束替换类名\n");

        MixLog(@"获取框架方法\n");
        
        NSMutableArray * frameworkMethods = [NSMutableArray arrayWithCapacity:0];
        for (NSString * framework in [MixConfig sharedSingleton].frameworkPaths) {
            NSArray <NSString *> * methods = [MixMethodStrategy methodsWithPath:framework];
            [frameworkMethods addObjectsFromArray:methods];
        }
        
        MixLog(@"获取替换方法名\n");
        NSArray <NSString *>* referenceMethods = [MixReferenceStrategy methodWithObjects:referenceObjects];
        MixLog(@"开始替换方法（请耐心等待）\n");
        [MixMainStrategy replaceMethod:copyObjects methods:referenceMethods systemMethods:frameworkMethods];
        MixLog(@"结束替换方法\n");

        MixLog(@"开始替换Protocol名称\n");
        if ([MixProtocolStrategy startWithPath:rootPath]) {
            MixLog(@"替换Protocol名称成功\n");
        }else {
            MixLog(@"替换Protocol名称出错了\n");
        }
        
        MixLog(@"开始替换Category名称\n");
        if ([[MixYAHCategoryStrategy shareInstance] start]) {
            MixLog(@"替换Category名称成功\n");
        }else {
            MixLog(@"替换Category名称出错了\n");
        }

        MixLog(@"开始替换文件名称\n");
        if ([MixFileNameStrategy start:copyObjects rootPath:rootPath mixPath:copyPath]) {
            MixLog(@"替换文件名称成功\n");
        }else {
            MixLog(@"替换文件名称出错了\n");
        }
    }
    return 0;
}
