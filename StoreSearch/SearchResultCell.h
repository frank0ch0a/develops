//
//  SearchResultCell.h
//  StoreSearch
//
//  Created by Francisco on 31/08/13.
//  Copyright (c) 2013 MaravillaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchResult;

@interface SearchResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *artWorkImageView;

-(void)configureForSearchresult:(SearchResult *)searchResult;

@end
