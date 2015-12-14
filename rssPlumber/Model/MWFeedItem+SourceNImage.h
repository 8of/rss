//
//  MWFeedItem+SourceNImage.h
//  rss-pumper
//
//  Created by Andrey Konstantinov on 07/06/15.
//  Copyright (c) 2015 8of. All rights reserved.
//
// Расширяем <MWFeed, добавляя ещё два параметра

#import <MWFeedParser/MWFeedItem.h>

@interface MWFeedItem (SourceNImage)

@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSURL *imageUrl;

@end
