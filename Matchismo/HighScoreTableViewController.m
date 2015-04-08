//
//  HighScoreTableViewController.m
//  Matchismo
//
//  Created by Gaurav Verma on 8/18/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import "HighScoreTableViewController.h"


#define SECTION_VIEW_HEIGHT 50
#define LABEL_VIEW_HEIGHT 20

@interface HighScoreTableViewController ()


@property (nonatomic) CGFloat labelViewRect;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sortButton;
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ascendingSwitch;
@property (strong, nonatomic) NSString *sortDescriptorKey;

@end

@implementation HighScoreTableViewController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)touchSortButton:(UIBarButtonItem *)sender {
    
    [self.actionSheet showInView:self.view];
    
    
}

- (NSString *)sortDescriptorKey
{
    if (!_sortDescriptorKey) {
        _sortDescriptorKey = @"Score";
    }
    
    return _sortDescriptorKey;
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
        NSString *sortDescriptorKey = buttonTitle;
        self.sortDescriptorKey = sortDescriptorKey;
        
        [self sortTable];
    }
    
    [self updateUI];
    
}

- (void)sortTable
{
    NSString *sortDescriptorKey = self.sortDescriptorKey;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // BRING UP HIGHSCORES DICTIONARY OF DIFFERENT GAMES
    NSDictionary *highScores = [defaults valueForKey:@"High Scores"];
    NSMutableDictionary *newHighScoresDictionary = [[NSMutableDictionary alloc] init];
    [newHighScoresDictionary addEntriesFromDictionary:highScores];
    
    for (id key in highScores) {
        // ACCESS ARRAY FOR SPECIFIC CARD TYPE
        NSArray *cardArray = [highScores valueForKey:key];
        NSLog(@"Number of elements in array: %d for key %@", (int)[cardArray count], key);
        
        BOOL ascending = self.ascendingSwitch.selectedSegmentIndex;
        
        if (cardArray) {
            //NSLog(@"Sorting");
            
            NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:sortDescriptorKey ascending:ascending];
            NSArray *sortDescriptorArray = [NSArray arrayWithObject:sortDescriptor];
            
            
            
            
            
            
            cardArray = [cardArray sortedArrayUsingDescriptors:sortDescriptorArray];
            
            
            //NSLog(@"Setting Set Card Dictionary Array");
            

            [newHighScoresDictionary setValue:cardArray forKey:key];
        }
    }
    
    
    
    
        
        
    [defaults setValue:newHighScoresDictionary forKey:@"High Scores"];
        
        
        
    
    
    
    
    [defaults synchronize];
    
    //    NSDictionary *highScoreDictionary1 = @{@"Score" : @52, @"Duration" : @24 , @"Date" : [NSDate date]};
    //    NSDictionary *highScoreDictionary2 =  @{@"Score" : @23, @"Duration" : @230 , @"Date" : [NSDate date]};
    //    NSDictionary *highScoreDictionary3 = @{@"Score" : @35, @"Duration" : @200 , @"Date" : [NSDate date]};
    //
    //    NSArray *highScoresArray = @[highScoreDictionary1, highScoreDictionary2, highScoreDictionary3];
    //
    //    NSSortDescriptor *highScoreSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"Duration" ascending:YES];
    //    NSArray *sortDescriptorArray = [NSArray arrayWithObject:highScoreSortDescriptor];
    //
    //    highScoresArray = [highScoresArray sortedArrayUsingDescriptors:sortDescriptorArray];
    //
    //
    //    NSLog(@"sorted array of dictionaries: %@", highScoresArray);
    
    //NSLog(@"Sorted");
    

}

- (void)aMethod
{
    NSLog(@"button");
}

- (void)createButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self
               action:@selector(aMethod)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Show View" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 80);
    [self.view addSubview:button];
    NSLog(@"%f %f %f %f", button.frame.origin.x, button.frame.origin.y, button.frame.size.width, button.frame.size.height);
    NSLog(@"%f %f %f %f", button.bounds.origin.x, button.bounds.origin.y, button.bounds.size.width, button.bounds.size.height);
    NSLog(@"%f %f", button.center.x, button.center.y);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self createButton];
    
    //[action showFromBarButtonItem:self.sortButton animated:YES];
    //[action showInView:self.parentViewController.view];
//
//    // Uncomment the following line to preserve selection between presentations.
//    // self.clearsSelectionOnViewWillAppear = NO;
//    
//    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    
////    CGRect rect = [self.tableView rectForHeaderInSection:0];
////    rect.origin.x+=self.tableView.separatorInset.left;
////    rect.origin.y = 0;
////    rect.size.height = 50;
////    self.sectionRect = rect;
////    
////    CGRect mainViewRect = CGRectMake(0, 0, , <#CGFloat height#>)
////    NSLog(@"%f %f %f %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
//    
//    //UIView *view = self.tableView.tableHeaderView;
//    
//    CGRect rect = [self.tableView rectForSection:0];
//    
//    NSLog(@"%f %f %f %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
//
//
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"HighScoreCell"];
    UIView *view = cell.contentView;
    CGRect rect = view.frame;
    rect.size.height -= 10;
    view.frame = rect;
    //view.backgroundColor = [UIColor blackColor];
//    //cell.frame = rect;
//        //UISwitch *testSwitch = self.testSwitch;
//    
//    UILabel *scoreLabel = [cell viewWithTag:100];
//    UILabel *durationLabel = [cell viewWithTag:101];
//    UILabel *dateLabel = [cell viewWithTag:102];
//    
//    CGRect scoreRect = scoreLabel.frame;
//    
//    
//    NSLog(@"%f %f %f %f", scoreRect.origin.x, scoreRect.origin.y, scoreRect.size.width, scoreRect.size.height);
//    
//    
//    UIButton *scoreButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    
//    
//    UIView *contentView = cell.contentView;
//    
//    
//    
//    
//    
//    //NSString *newButtonText = newButton.currentTitle;
//    //NSLog(newButtonText);
//    
//    //newButton.enabled = YES;
//    
//    UIButton *newerButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    //newerButton.backgroundColor = [UIColor blackColor];
//    [newerButton setTitle:@"abc" forState:UIControlStateNormal];
//    newerButton.tintColor = [UIColor whiteColor];
//    newerButton.enabled = YES;
//    newerButton.backgroundColor = [UIColor blackColor];
//    newerButton.frame = scoreLabel.frame;
//    UIFont *font = newerButton.titleLabel.font;
//    newerButton.titleLabel.font = [font fontWithSize:17];
//    if (newerButton.titleLabel)
//    {
//        NSLog(@"newerButton titleLabel");
//    }
//    [contentView addSubview:newerButton];
//    //NSLog(newerButton.titleLabel.text);
//    
//    
//    
//    NSArray *numContents = contentView.subviews;
//    
//    NSLog(@"%d", [numContents count]);
//    
//    
//    //UIView *cellView2 = cellSubViewArray[0];
//    
//    //NSArray *cellSubViewArray2 = cellView2.subviews;
//    
//    //CGRect cellRect = cellView2.frame;
//    
//    UIView *testView = [[UIView alloc] initWithFrame:rect];
//    
//    
//    //testView.backgroundColor = [UIColor blackColor];
//    //[testView addSubview:newerButton];
//    
//    
//    
//    
//    
//    
//    
//    
//    [scoreLabel removeFromSuperview];
//    
//    numContents = contentView.subviews;
//    
//    NSLog(@"%d", [numContents count]);
//    
    if (!self.tableView.tableHeaderView) {
        self.tableView.tableHeaderView = view; //view;
    }
//
//    
//    //UIFont *font = [UIFont systemFontOfSize:17];
//    
//    
//    //UIView *label = [cell viewWithTag:100];
//    //UIView *labelCopy = [label mutableCopy];
//    
//   // [self.testSwitch.]
//    
//    //[self.testSwitch addSubview:label];
//    
//    
    
}

- (IBAction)ascendingOrderChanged {
    [self sortTable];
    [self updateUI];
}

- (UIActionSheet*)actionSheet
{
    if (!_actionSheet)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Sort Scores By:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Score", @"Duration", @"Date", nil];
        _actionSheet = actionSheet;
        
    }
    
    return _actionSheet;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *highScores = [defaults valueForKey:@"High Scores"];
    
    NSUInteger rowCount = 0;
    for (id key in highScores) {
        if ([highScores valueForKey:key]) {
            rowCount++;
        }
    }
    
    return rowCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    // Return the number of rows in the section.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *highScores = [defaults valueForKey:@"High Scores"];
    NSArray *cardKeyArray = [highScores allKeys];
    
    if (cardKeyArray) {
        
        NSArray *thisCardHighScoreArray = highScores[cardKeyArray[section]];
        if (thisCardHighScoreArray) {
            return [thisCardHighScoreArray count];
        }
        
    }
    
    return 0;
    
    
    
}


- (void) updateUI
{
    [self.tableView reloadData];
    
}
- (void) viewDidAppear:(BOOL)animated
{
    [self sortTable];
    [self updateUI];
    //CGRect rect = [self.tableView rectForHeaderInSection:1];
    //NSLog(@"%f %f %f %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HighScoreCell" forIndexPath:indexPath];
    
    
    UILabel *scoreLabel = (UILabel *)[cell viewWithTag:100];
    UILabel *durationLabel = (UILabel *)[cell viewWithTag:101];
    UILabel *dateLabel = (UILabel *) [cell viewWithTag:102];
    
    
    
    // BRING UP DEFAULTS DATABASE
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // BRING UP HIGHSCORES DICTIONARY OF DIFFERENT GAMES
    NSDictionary *highScores = [defaults valueForKey:@"High Scores"];
    
    // ARRAY OF DIFFERENT CARD GAME KEYS
    NSArray *arrayOfKeys = [highScores allKeys];
    
    // FINDS THIS SECTIONS SPECIFIC CARD GAME TITLE
    NSString *highScoreKey = arrayOfKeys[indexPath.section];
    
    
    // GETS THE ARRAY OF DICTIONARIES FOR THIS SPECIFIC CARD GAME IN THIS SECTION
    NSArray *thisCardHighScoresArray = [highScores valueForKey:highScoreKey]; //returns array of dictionaries from highscorekey
    
    // GETS THE DICTIONARY FOR THIS SPECFIC ROW
    NSDictionary *thisRowHighScoreDictionary = [thisCardHighScoresArray objectAtIndex:indexPath.row];
    
    

    
    NSDate *date = [thisRowHighScoreDictionary valueForKey:@"Date"];
    double duration = [[thisRowHighScoreDictionary valueForKey:@"Duration"] doubleValue];
    double score = [[thisRowHighScoreDictionary valueForKey:@"Score"] doubleValue];
    
    // Configure the cell...
    
    scoreLabel.text = [NSString stringWithFormat:@"%d",  (int)score];
    
    durationLabel.text = [NSString stringWithFormat:@"%d", (int)duration];
    
    
    dateLabel.text = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];

    
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    //NSLog(@"%f %f %f %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    
    return @"Test";
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //UILabel *label = [[UILabel alloc] initWith.:CGRectMake(self.sectionRect.origin.x, 0, self.sectionRect.size.width, self.sectionRect.size.height)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(tableView.separatorInset.left, [self tableView:self.tableView heightForHeaderInSection:section]-LABEL_VIEW_HEIGHT, 320, LABEL_VIEW_HEIGHT)];
    
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *highScores = [defaults valueForKey:@"High Scores"];
    NSArray *arrayOfKeys = [highScores allKeys];
    
    NSString *highScoreKey = arrayOfKeys[section];
    
    label.text = highScoreKey;
    //label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont boldSystemFontOfSize:15];
    
    
    //return label;
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    
                    
    view.backgroundColor = [UIColor clearColor];
    
    
    [view addSubview:label];
    
    return  view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section) {
        return SECTION_VIEW_HEIGHT;
    }
    
    return LABEL_VIEW_HEIGHT;
        //return self.sectionRect.size.height;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
