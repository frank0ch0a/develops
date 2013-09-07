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

-(NSString *)kindForDisplay:(NSString *)kind
{
    if ([kind isEqualToString:@"album"]) {
        
        return @"Album";
        
    }else if ([kind isEqualToString:@"audiobook"]){
        
        return @"Audio Book";
        
    }else if ([kind isEqualToString:@"book"]){
        
        return @"Book";
        
    }else if ([kind isEqualToString:@"ebook"]){
        
        return @"E-book";
        
    }else if ([kind isEqualToString:@"feature-movie"]){
        
        return @"Movie";
    }else if ([kind isEqualToString:@"music-video"]){
        
        return @"Music Video";
        
    }else if ([kind isEqualToString:@"podcast"]){
        
        return @"Podcast";
        
    }else if ([kind isEqualToString:@"software"]){
        
        return @"App";
        
    }else if ([kind isEqualToString:@"song"]){
        
        return @"Song";
        
    }else if ([kind isEqualToString:@"tv-episode"]){
        
        
        return @"TV Episode";
    }else{
        
        return kind;
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
        
    NSString *artistName=searchResult.artistName;
        
        if (artistName==nil) {
            artistName=@"Unknown";
        }
        
        NSString *kind=[self kindForDisplay:searchResult.kind];
        cell.artistNameLabel.text=[NSString stringWithFormat:@"%@ (%@)",artistName,kind];
        
    
       
          return cell;
        
    }
    
    
  
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
-(void)showNetworkError
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Whoops.."
                                                     message:@"There was sn error reading from itunes Store. please try again." delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil ];
    
    [alertView show];
    
    
    
}

-(SearchResult *)parseTrack:(NSDictionary *)dictionary
{
    SearchResult *searchResult=[[SearchResult alloc]init];
    
    searchResult.name=[dictionary objectForKey:@"trackName"];
    searchResult.artistName=[dictionary objectForKey:@"artistName"];
    searchResult.artworkURL60=[dictionary objectForKey:@"artworkURL60"];
    searchResult.artworkURL100=[dictionary objectForKey:@"artworkURL100"];
    searchResult.storeURL=[dictionary objectForKey:@"trackViewURL"];
    searchResult.kind=[dictionary objectForKey:@"kind"];
    searchResult.price=[dictionary objectForKey:@"trackPrice"];
    searchResult.currency=[dictionary objectForKey:@"currency"];
    searchResult.genre=[dictionary objectForKey:@"primaryGenreName"];
    
    return searchResult;
    
    
    
    
    
}

-(SearchResult *)parseAudiobook:(NSDictionary *)dictionary
{
    SearchResult *searchResult=[[SearchResult alloc]init];
    
    searchResult.name=[dictionary objectForKey:@"collectionName"];
    searchResult.artistName=[dictionary objectForKey:@"artisName"];
    searchResult.artworkURL60=[dictionary objectForKey:@"artworkUrl60"];
    searchResult.artworkURL100=[dictionary objectForKey:@"artworkUrl100"];
    searchResult.storeURL=[dictionary objectForKey:@"collectionViewUrl"];
    searchResult.kind=@"audiobook";
    searchResult.price=[dictionary objectForKey:@"collectionPrice"];
    searchResult.currency=[dictionary objectForKey:@"currency"];
    searchResult.genre=[dictionary objectForKey:@"primaryGenreName"];
    return searchResult;
    
    
}

-(SearchResult *)parseSoftware:(NSDictionary *)dictionary
{
    SearchResult *searchResult=[[SearchResult alloc]init];
    
    searchResult.name=[dictionary objectForKey:@"trackName"];
    searchResult.artistName=[dictionary objectForKey:@"artisName"];
    searchResult.artworkURL60=[dictionary objectForKey:@"artworkUrl60"];
    searchResult.artworkURL100=[dictionary objectForKey:@"artworkUrl100"];
    searchResult.storeURL=[dictionary objectForKey:@"trackViewUrl"];
    searchResult.kind=[dictionary objectForKey:@"kind"];
    searchResult.price=[dictionary objectForKey:@"price"];
    searchResult.currency=[dictionary objectForKey:@"currency"];
    searchResult.genre=[dictionary objectForKey:@"primaryGenreName"];
    return searchResult;

    
}
-(SearchResult *)parseEbook:(NSDictionary *)dictionary
{
    SearchResult *searchResult=[[SearchResult alloc]init];
    
    searchResult.name=[dictionary objectForKey:@"trackName"];
    searchResult.artistName=[dictionary objectForKey:@"artisName"];
    searchResult.artworkURL60=[dictionary objectForKey:@"artworkUrl60"];
    searchResult.artworkURL100=[dictionary objectForKey:@"artworkUrl100"];
    searchResult.storeURL=[dictionary objectForKey:@"trackViewUrl"];
    searchResult.kind=[dictionary objectForKey:@"kind"];
    searchResult.price=[dictionary objectForKey:@"price"];
    searchResult.currency=[dictionary objectForKey:@"currency"];
    searchResult.genre=[(NSArray *)[dictionary objectForKey:@"genres"]componentsJoinedByString:@", "];
    return searchResult;

    
    
}

-(void)parseDictionary:(NSDictionary *)dictionary
{
    NSArray *array=[dictionary objectForKey:@"results"];
    
    if (array==nil) {
        NSLog(@"Expected 'results' array");
        
        return;
        
    }

    for(NSDictionary *resultDict in array){
    
        SearchResult *searchResult;
        
        NSString *wrapperType=[resultDict objectForKey:@"wrapperType"];
        //NSString *kind=[resultDict objectForKey:@"kind"];
        
        
        if ([wrapperType isEqualToString:@"track"]){
            searchResult=[self parseTrack:resultDict];
                       
            
        }else if ([wrapperType isEqualToString:@"audiobook"]){
            
            searchResult=[ self parseAudiobook:resultDict];
            
        }else if ([wrapperType isEqualToString:@"software"]){
            
            searchResult=[self parseSoftware:resultDict];
            
            
        }else if ([wrapperType isEqualToString:@"ebook"]){
            
            searchResult=[self parseEbook:resultDict];
            
        }
        
        if(searchResult!=nil){
            
            [searchResults addObject:searchResult];
        }

    
    }

    
    
}
-(NSDictionary *)parseJSON:(NSString *)jsonString
{
    NSData *data=[jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    
    id resultObject=[NSJSONSerialization JSONObjectWithData:data
                                                    options:kNilOptions error:&error];
    
    if (resultObject==nil) {
        NSLog(@"JSON Error:%@ ",error);
        
        return nil;
        
    }
    
    if (![resultObject isKindOfClass:[NSDictionary class]]) {
        NSLog(@"JSON Error: Expected Ditionary");
        return nil;
        
    }
    
    return resultObject;
    
    
    
}

#pragma mark -searchBarDelegate

-(NSString *)performStoreRequestWithURL:(NSURL *)url
{
    NSError *error;
    NSString *resultString=[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    if (resultString==nil) {
        NSLog(@"Download error: %@",error);
    }
    
    return resultString;
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if ([searchBar.text length]>0) {
        
    
    
     [searchBar resignFirstResponder];
    
    searchResults=[NSMutableArray arrayWithCapacity:10];
    
    NSURL *url=[self urlWithSearchText:searchBar.text];
    
        NSString *jsonString=[self performStoreRequestWithURL:url];
        
        if (jsonString==nil) {
            [self showNetworkError];
            return;
        }
        
        
        NSDictionary *dictionary=[self parseJSON:jsonString];
        
        if (dictionary==nil) {
            [self showNetworkError];
            return;
        }
        
        NSLog(@"Dictionary: %@",dictionary);
        
        [self parseDictionary:dictionary];
        [searchResults sortUsingSelector:@selector(compareName:)];
      
        [self.tableView reloadData];
    }
    
}


-(NSURL *)urlWithSearchText:(NSString *)searchText
{
    
    NSString *escapedSearchText=[searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString *urlString=[NSString stringWithFormat:@"http://itunes.apple.com/search?term=%@",escapedSearchText];
    
    NSURL *url=[NSURL URLWithString:urlString];
    
    return url;
    
}
@end
