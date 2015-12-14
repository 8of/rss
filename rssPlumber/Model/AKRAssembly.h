//
//  AKRAssembly.h
//  rss-pumper
//
//  Created by Andrey Konstantinov on 07/06/15.
//  Copyright (c) 2015 8of. All rights reserved.
//
// Typhoon-фабрика зависимостей между Фабрикой генерации RSS-записей и контроллером RSS-ленты

#import <Typhoon/TyphoonAssembly.h>
#import <Foundation/Foundation.h>

#import "AKRRssService.h"

#import "AKRRssListViewController.h"

@class AKRAssembly;
@class AKRRssService;

@interface AKRAssembly : TyphoonAssembly

- (AKRRssService *)rssService;
- (AKRRssListViewController *)baseViewController;

@end
