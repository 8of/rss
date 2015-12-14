//
//  AKRRssService.m
//  rss-pumper
//
//  Created by Andrey Konstantinov on 07/06/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import <MWFeedParser/MWFeedParser.h>
#import "MWFeedItem+SourceNImage.h"

#import "AKRRssService.h"

@interface AKRRssService () <MWFeedParserDelegate>

/**
 *  3rd-party-парсер RSS-ленты.
 *  Занимается сетевым уровнем и маппингом.
 *  Генерирует полуготовые объекты.
 */
@property (nonatomic, strong) MWFeedParser *feedParser;
/// Массив URL-адресов для получения RSS, представленных как объекты класса NSURL
@property (nonatomic, strong) NSArray *arrayOfNSUrls;
/// Массив объектов класса MWFeedItem, которые добавляются в массив по мере поступления
@property (nonatomic, strong) NSMutableArray *arrayOfFeedItems;
/// Количество полученных RSS-лент
@property (nonatomic, assign) NSInteger countOfFeedParsed;

@end

@implementation AKRRssService

/**
 *  Запрещаем использовать init,
 *  подсказываем как правильно использовать нашу фабрику.
 *
 *  @return nil
 */
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Need additional parameters"
                                   reason:@"Use -[[AKRRssAssembly alloc] initWithUrlStringsArray:] instead"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initWithUrlStringsArray:(NSArray *)urlStringsArray
{
    self = [super init];

    if (self) {
        _countOfFeedParsed = 0;
        _arrayOfFeedItems = [@[] mutableCopy];

        NSMutableArray *arrayOfNSUrlsMutable = [@[] mutableCopy];

        // Преобразовываем поступивший массив NSString-ов в удобным для работы массив NSURL-ов
        for (NSString *urlString in urlStringsArray) {
            NSURL *rssUrl = [[NSURL alloc] initWithString:urlString];
            [arrayOfNSUrlsMutable addObject:rssUrl];
        }

        _arrayOfNSUrls = [arrayOfNSUrlsMutable copy];
        arrayOfNSUrlsMutable = nil;
    }

    return self;
}

- (void)startRssPumping
{
    if (_countOfFeedParsed < _arrayOfNSUrls.count) { // Случай когда ещё есть не парсенные ленты
        /**
         *  Проставляем все настройки для одной "текущей" RSS-ленты 
         *  и запускаем получение RSS-ленты
         */
        NSURL *feedUrl = _arrayOfNSUrls[_countOfFeedParsed];
        _feedParser = [[MWFeedParser alloc] initWithFeedURL:feedUrl];
        _feedParser.delegate = self;
        _feedParser.feedParseType = ParseTypeFull;
        _feedParser.connectionType = ConnectionTypeAsynchronously;
        [_feedParser parse];
    } else { // Случай когда ленты все пройдены, RSS-записи собраны
        // Запускаем метод сортировки списка из всех RSS-записей
        [self reorderFeedItemsInArray:_arrayOfFeedItems];
    }
}

/**
 *  Метод сортирует объекты массива в порядке убывания по свойству date класса NSDate
 *  (более новые RSS-записи становятся первыми)
 *
 *  @param feedItemsArray массив объектов класса MWFeedItem
 */
- (void)reorderFeedItemsInArray:(NSArray *)feedItemsArray
{
    NSArray *feedItems;
    feedItems = [feedItemsArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = [(MWFeedItem *)a date];
        NSDate *second = [(MWFeedItem *)b date];
        return [second compare:first];
    }];
    _feedItems = feedItems;
    // Отправляем делегату сообщение о том, что лента готова
    [_rssServiceDelegate feedParsedWithFeedItems:feedItems];
}

#pragma mark - MWFeedParserDelegate
/// Делегатный метод - вызывается при завершении парсинга ОДНОЙ (!) RSS-ленты
- (void)feedParserDidFinish:(MWFeedParser *)parser
{
    // Увеличиваем количество отпарсенных лент на 1
    _countOfFeedParsed++;
    // Запускаем запрос на парсинг снова
    [self startRssPumping];
}

/// Делегатный метод - вызывается при парсинге КАЖДОГО (!) объекта RSS-ленты
- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item
{
    // Получаем хост для дальнейшего отображения как источника
    NSURL *sourceUrl = [[NSURL alloc] initWithString:item.link];
    item.host = sourceUrl.host;

    // Получаем ссылку на изображение, если оно есть
    if ([item.enclosures[0][@"type"] isEqualToString:@"image/jpeg"]) {
        item.imageUrl = [[NSURL alloc] initWithString:item.enclosures[0][@"url"]];
    }

    // Добавляем объект RSS-записи в общий массив
    [_arrayOfFeedItems addObject:item];
}

/**
 *  Делегатный метод - вызывается при ошибке парсинга, 
 *  обычно здесь подключается вывод статуса/ алерта.
 */
- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error
{
    NSLog(@"Error while parsing: %@", error.localizedDescription);
}

@end
