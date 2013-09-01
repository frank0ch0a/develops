//
//  ViewController.m
//  StoreSearch
//
//  Created by Francisco on 31/08/13.
//  Copyright (c) 2013 MaravillaTech. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResult.h"
#import "SearchResultCell.h"

static NSString *const SearchResultCellIdentifier=@"SearchResultCell";
static NSString *const NothingFoundCellIdentifier=@"NothingFoundCell";

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation SearchViewController
{
    
    NSMutableArray *searchResults;
    
}
@synthesize searchBar=_searchBar;
@synthesize tableView=_tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UINib *cellNib=[UINib nibWithNibName:SearchResultCellIdentifier bundle:nil];
    
        [self.tableView registerNib:cellNib forCellReuseIdentifier:SearchResultCellIdentifier];
    
    
    cellNib=[UINib nibWithNibName:NothingFoundCellIdentifier bundle:nil];
    
    [self.tableView registerNib:cellNib forCellReuseIdentifier:NothingFoundCellIdentifier];
    
    self.tableView.rowHeight=80;
    
    [self.searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -TableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (searchResults==nil) {
        return 0;
    }else if ([searchResults count]==0){
        
        return 1;
        
    }else{
    
        return [searchResults count];
        
    }
        
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    


    
    
    if ([searchResults count]==0) {
       
        return [tableView dequeueReusableCellWithIdentifier:NothingFoundCellIdentifier];
    }else{
        
            SearchResultCell *cell=[tableView dequeueReusableCellWithIdentifier:SearchResultCellIdentifier];
    
    SearchResult *searchResult=[searchResults objectAtIndex:indexPath.row];

    
    cell.nameLabel.text=searchResult.name;
    cell.artistNameLabel.text=searchResult.artistName;
       
          return cell;
        
    }
    
    
  
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

#pragma mark -searchBarDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
     [searchBar resignFirstResponder];
    
    searchResults=[NSMutableArray arrayWithCapacity:10];
    
    if (![searchBar.text isEqualToString:@"batman"]) {
        
    
    
    for (int i=0; i<3; i++) {
        
        SearchResult *searchResult=[[SearchResult alloc]init];
        
        searchResult.name=[NSString stringWithFormat:@"Fake Result %d for",i];
        searchResult.artistName=searchBar.text;
        [searchResults addObject:searchResult];
        
        
        }
    }
   
        [self.tableView reloadData];
    
    
}

@end
