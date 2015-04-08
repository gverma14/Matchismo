//
//  SettingsViewController.m
//  Matchismo
//
//  Created by Gaurav Verma on 8/19/14.
//  Copyright (c) 2014 SwaguEnt. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *difficultySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *matchBonusToggle;
@property (strong, nonatomic) UIActionSheet *actionSheet;

@end

@implementation SettingsViewController

- (IBAction)clearDataButton:(UIBarButtonItem *)sender {
    
    [self.actionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        
    }
    
    
}




- (UIActionSheet*)actionSheet
{
    if (!_actionSheet)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Delete High Scores?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles: nil];
        _actionSheet = actionSheet;
        
    }
    
    return _actionSheet;
}

- (void)viewWillDisappear:(BOOL)animated
{
    //USED FOR DELETING NSUSERDEFAULT KEYS DELETE DEFAULTS REMOVE DESTROY
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL matchBonus = self.matchBonusToggle.isOn;
    int mismatchSelection = (int)self.difficultySwitch.selectedSegmentIndex+1;
    int cost = mismatchSelection;
    
    [defaults setBool:matchBonus forKey:@"MATCH_BONUS"];
    [defaults setInteger:mismatchSelection forKey:@"MISMATCH_PENALTY"];
    [defaults setInteger:cost forKey:@"COST_TO_CHOOSE"];
    
    [defaults synchronize];
    
    
    
    
}





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
