//
//  AKRRssListViewController.h
//  rss-pumper
//
//  Created by Andrey Konstantinov on 06/06/15.
//  Copyright (c) 2015 8of. All rights reserved.
//
// Контроллер для отображения RSS-ленты

#import <UIKit/UIKit.h>

#import "AKRRssService.h"

@interface AKRRssListViewController : UITableViewController

@property (nonatomic, strong) AKRRssService *rssService;

@end
