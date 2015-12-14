//
//  AKRRssTableViewCell.h
//  rss-pumper
//
//  Created by Andrey Konstantinov on 07/06/15.
//  Copyright (c) 2015 8of. All rights reserved.
//
// Ячейка для отображения всех данных RSS-новости

#import <UIKit/UIKit.h>

@interface AKRRssTableViewCell : UITableViewCell

- (void)prepareCellWithTitle:(NSString *)title andSource:(NSString *)source andImageUrl:(NSURL *)imageUrl andDescription:(NSString *)description;

@end
