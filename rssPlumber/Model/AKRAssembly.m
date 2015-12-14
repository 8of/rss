//
//  AKRAssembly.m
//  rss-pumper
//
//  Created by Andrey Konstantinov on 07/06/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKRConstants.h"

#import "AKRAssembly.h"
#import "AKRRssService.h"

@implementation AKRAssembly

/// Инжектим в контроллер фабрику RSS-записей
- (AKRRssListViewController *)baseViewController {
    return [TyphoonDefinition withClass:[AKRRssListViewController class]
                          configuration:^(TyphoonDefinition *definition) {

                            [definition injectProperty:@selector(rssService) with:[self rssService]];
                          }];
}

/// Конфигурируем фабрику RSS-записей данным по умолчанию
- (AKRRssService *)rssService
{
    return [TyphoonDefinition withClass:[AKRRssService class]
                          configuration:^(TyphoonDefinition *definition) {

                              [definition useInitializer:@selector(initWithUrlStringsArray:)
                                              parameters:^(TyphoonMethod *initializer) {
                                                  [initializer injectParameterWith:[self defaultUrlStringArray]];

                                              }];
                          }];
}

/**
 *  Генератор списка адресов по-умолчанию для получения общей RSS-ленты
 *
 *  @return список адресов для получения общей RSS-ленты
 */
- (NSArray *)defaultUrlStringArray
{
    NSArray *urlStringArray = @[
        RSS_URL_1,
        RSS_URL_2
    ];

    return urlStringArray;
}

@end
