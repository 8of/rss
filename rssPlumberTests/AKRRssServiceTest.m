//
//  AKRRssServiceTest.m
//  rss-pumper
//
//  Created by Andrey Konstantinov on 07/06/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <Typhoon/Typhoon.h>

#import "AKRConstants.h"

#import "MWFeedItem+SourceNImage.h"
#import "AKRAssembly.h"
#import "AKRRssAssembly+AKRRssAssemblyCategoryTesting.h"

@interface AKRRssServiceTest : XCTestCase

@end

@implementation AKRRssServiceTest

/// Метод должен правильно сортировать по дате - в данном случае переворачивать массив наоборот
- (void)testReorderFeedItemsInArray
{
    AKRAssembly *akrassembly = [AKRAssembly assembly];

    TyphoonComponentFactory *factory = [TyphoonBlockComponentFactory factoryWithAssembly:akrassembly];
    AKRRssService *rssService = [(AKRAssembly *)factory rssService];

    NSDate *today = [NSDate date];

    // Интервал разницы взят из гугла
    NSDate *yesterday = [today dateByAddingTimeInterval: -86400.0];

    MWFeedItem *feedItem1 = [[MWFeedItem alloc] init];
    feedItem1.date = today;
    MWFeedItem *feedItem2 = [[MWFeedItem alloc] init];
    feedItem2.date = yesterday;

    NSArray *arrayOfFeedItemsInWrongOrder = @[
        feedItem2,
        feedItem1
    ];

    [rssService reorderFeedItemsInArray:arrayOfFeedItemsInWrongOrder];

    XCTAssertEqualObjects(rssService.feedItems[0], feedItem1);
    XCTAssertEqualObjects(rssService.feedItems[1], feedItem2);
}

/// Попытка инициализации через init должна выдавать Exception
- (void)testRssServiceInitShouldFail
{
    XCTAssertThrows([[AKRRssService alloc] init]);
}

/// Проверка - получается ли у RSS-сервиса получить какие-либо данные и записать их
- (void)testStartRssPumpingAndCheckFeedItemsPresence
{
    AKRAssembly *akrassembly = [AKRAssembly assembly];

    TyphoonComponentFactory *factory = [TyphoonBlockComponentFactory factoryWithAssembly:akrassembly];
    AKRRssService *rssService = [(AKRAssembly *)factory rssService];

    [rssService startRssPumping];

    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:5.0];

    while ([timeoutDate timeIntervalSinceNow] > 0) {
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0, YES);
    }

    XCTAssertNotNil(rssService.feedItems);
}

@end
