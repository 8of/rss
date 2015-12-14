//
//  AKRRssTableViewCell.m
//  rss-pumper
//
//  Created by Andrey Konstantinov on 07/06/15.
//  Copyright (c) 2015 8of. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>

#import "AKRRssTableViewCell.h"

@interface AKRRssTableViewCell ()
/// Картинка, прикреплённая к новости
@property (nonatomic, weak) IBOutlet UIImageView *rssImageView;
/// Заголовок новости
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
/// Источник новости
@property (nonatomic, weak) IBOutlet UILabel *sourceLabel;
/// Описание новости
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;

@end

@implementation AKRRssTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    _rssImageView.contentMode = UIViewContentModeScaleAspectFill;
    _rssImageView.clipsToBounds = YES;
}

- (void)prepareCellWithTitle:(NSString *)title andSource:(NSString *)source andImageUrl:(NSURL *)imageUrl andDescription:(NSString *)description
{
    _titleLabel.text = title;
    _sourceLabel.text = source;
    _descriptionLabel.text = description;

    [_rssImageView setImageWithURL:imageUrl
                  placeholderImage:[UIImage imageNamed:@"Rss.png"]];
}

- (void)prepareForReuse
{
    [super prepareForReuse];

    _titleLabel.text = @"";
    _sourceLabel.text = @"";
    _descriptionLabel.text = @"";
    [_rssImageView setImage:[UIImage imageNamed:@"Rss.png"]];
}

@end
