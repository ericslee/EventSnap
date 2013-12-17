//
//  EventsListsViewCell.m
//  EventSnap
//
//  Created by Tara Siegel on 12/17/13.
//  Copyright (c) 2013 Eric Lee. All rights reserved.
//

#import "EventsListsViewCell.h"

@implementation EventsListsViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont fontWithName:@"Noteworthy" size:15.0];
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.font = [UIFont fontWithName:@"Noteworthy" size:12.0];
        _locationLabel = [[UILabel alloc]init];
        _locationLabel.font = [UIFont fontWithName:@"Noteworthy" size:10.0];
        _imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_dateLabel];
        [self.contentView addSubview:_locationLabel];
        [self.contentView addSubview:_imgView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    frame= CGRectMake(boundsX+10 ,0, 60, 60);
    _imgView.frame = frame;
    
    frame= CGRectMake(boundsX+90 ,10, 200, 25);
    _titleLabel.frame = frame;
    
    frame= CGRectMake(boundsX+90 ,34, 200, 15);
    _dateLabel.frame = frame;
    
    frame= CGRectMake(boundsX+90 ,36, 200, 45);
    _locationLabel.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
