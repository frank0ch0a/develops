//
//  SearchResultCell.m
//  StoreSearch
//
//  Created by Francisco on 31/08/13.
//  Copyright (c) 2013 MaravillaTech. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell

@synthesize nameLabel=_nameLabel;
@synthesize artistNameLabel=_artistNameLabel;
@synthesize artWorkImageView=_artWorkImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)awakeFromNib
{
    
    [super awakeFromNib];
    
    
    UIImage *image=[UIImage imageNamed:@"TableCellGradient"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithImage:image];
    self.backgroundView=backgroundImageView;
    
    UIImage *selectedImage=[UIImage imageNamed:@"SelectedTableCellGradient"];
    UIImageView *selectBackgroundImageView=[[UIImageView alloc] initWithImage:selectedImage];
    self.selectedBackgroundView=selectBackgroundImageView;
    
    
    
    
}

@end
