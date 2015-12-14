//
//  AKRRssService.h
//  rss-pumper
//
//  Created by Andrey Konstantinov on 07/06/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

/**
 *  Класс генерации RSS ленты из массива предоставленных адресов на  RSS-ленты
 *
 *  @return фабрика, с помощью которой можно получать RSS-записи
 */

#import <Foundation/Foundation.h>

@class AKRRssService;

@protocol AKRRssServiceDelegate <NSObject>

/**
 *  Делегатный метод, получающий массив RSS-записей, отсортированных по дате,
 *  от самой свежей новости к самой старой.
 *
 *  @param feedItems массив объектов класса MWFeedItem
 */
- (void)feedParsedWithFeedItems:(NSArray *)feedItems;

@end

@interface AKRRssService : NSObject

@property (nonatomic, weak) id<AKRRssServiceDelegate> rssServiceDelegate;
/// Массив объектов класса MWFeedItem, отсортированных по дате
@property (nonatomic, strong) NSArray *feedItems;

/**
 *  Инициализация фабрики RSS-записей
 *
 *  @param urlStringsArray массив URL-адресов RSS-лент, записанных как NSString
 *
 *  @return фабрика RSS-записей
 */
- (instancetype)initWithUrlStringsArray:(NSArray *)urlStringsArray;

/// Начать скачивание RSS-лент
- (void)startRssPumping;

@end
