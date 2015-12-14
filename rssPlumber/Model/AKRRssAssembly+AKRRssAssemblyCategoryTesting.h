//
//  AKRRssAssembly+AKRRssAssemblyCategoryTesting.h
//  rssPlumber
//
//  Created by Andrey Konstantinov on 08/06/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

// Категория для тестирования RSS-фабрики

#import "AKRRssService.h"

@interface AKRRssService (AKRRssAssemblyCategoryTesting)

- (void)reorderFeedItemsInArray:(NSArray *)feedItemsArray;

@end
