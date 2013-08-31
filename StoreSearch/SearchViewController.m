//
//  ViewController.m
//  StoreSearch
//
//  Created by Francisco on 31/08/13.
//  Copyright (c) 2013 MaravillaTech. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResult.h"

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
	// Do any additional setup after loading the view, typically from a nib.
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
    static NSString *CellIdentifier=@"SearchResultCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
        
    
    
    if ([searchResults count]==0) {
        cell.textLabel.text=@"(Nothing found)";
        cell.detailTextLabel.text=@"";
    }else{
    
    SearchResult *searchResult=[searchResults objectAtIndex:indexPath.row];

    
    cell.textLabel.text=searchResult.name;
    cell.detailTextLabel.text=searchResult.artistName;
    }
    
    
    return cell;
    
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
