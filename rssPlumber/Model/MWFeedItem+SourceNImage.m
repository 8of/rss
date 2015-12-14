//
//  MWFeedItem+SourceNImage.m
//  rss-pumper
//
//  Created by Andrey Konstantinov on 07/06/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import <objc/runtime.h>

#import "MWFeedItem+SourceNImage.h"

@implementation MWFeedItem (SourceNImage)

- (NSString *)host
{
    return objc_getAssociatedObject(self, @selector(host));
}

- (void)setHost:(NSString *)host
{
    objc_setAssociatedObject(self, @selector(host), host, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSURL *)imageUrl
{
    return objc_getAssociatedObject(self, @selector(imageUrl));
}

- (void)setImageUrl:(NSURL *)imageUrl
{
    objc_setAssociatedObject(self, @selector(imageUrl), imageUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
