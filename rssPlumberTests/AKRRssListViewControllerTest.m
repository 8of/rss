//
//  AKRRssListViewControllerTest.m
//  rssPlumber
//
//  Created by Andrey Konstantinov on 09/06/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Typhoon/Typhoon.h>

#import "AKRAssembly.h"

#import "AKRRssListViewController.h"

@interface AKRRssListViewControllerTest : XCTestCase

@end

@implementation AKRRssListViewControllerTest

/// Проверка удачного инжекта, не nil ли сервис RSS у контроллера
- (void)testRssServiceControllerDependency
{
    AKRAssembly *akrassembly = [AKRAssembly assembly];

    TyphoonComponentFactory *factory = [TyphoonBlockComponentFactory factoryWithAssembly:akrassembly];

    AKRRssListViewController *rssListViewController = [(AKRAssembly *)factory baseViewController];

    XCTAssertNotNil(rssListViewController);
    XCTAssertNotNil(rssListViewController.rssService);
}

@end
