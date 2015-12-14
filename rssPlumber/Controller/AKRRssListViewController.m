//
//  AKRRssListViewController.m
//  rss-pumper
//
//  Created by Andrey Konstantinov on 06/06/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import <MWFeedParser/MWFeedItem.h>
#import "AKRConstants.h"
#import "MWFeedItem+SourceNImage.h"

#import "AKRRssListViewController.h"

#import "AKRRssTableViewCell.h"

@interface AKRRssListViewController () <AKRRssServiceDelegate>

@property (nonatomic, strong) NSArray *feedItems;

@end

@implementation AKRRssListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.estimatedRowHeight = RSS_CELL_DEFAULT_HEIGHT;
    self.tableView.rowHeight = RSS_CELL_DEFAULT_HEIGHT;

    _rssService.rssServiceDelegate = self;
    [_rssService startRssPumping];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _feedItems.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Отключаем все системные отступы для разделителя, чтобы применились соответствующие настройки из IB

    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath == self.tableView.indexPathForSelectedRow) {
        return UITableViewAutomaticDimension;
    }
    return RSS_CELL_DEFAULT_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AKRRssTableViewCell *rssTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:RSS_CELL_ID
                                                                                 forIndexPath:indexPath];

    MWFeedItem *feedItem = _feedItems[indexPath.row];

    [rssTableViewCell prepareCellWithTitle:feedItem.title
                                 andSource:feedItem.host
                               andImageUrl:feedItem.imageUrl
                            andDescription:feedItem.summary];

    return rssTableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView beginUpdates];
    [self.tableView endUpdates];

    // Плавный эффект деселекта ячейки - что может быть лучше
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - AKRRssServiceDelegate

- (void)feedParsedWithFeedItems:(NSArray *)feedItems
{
    _feedItems = feedItems;
    [self.tableView reloadData];
}

@end
