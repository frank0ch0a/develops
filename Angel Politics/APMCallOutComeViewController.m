//
//  APMCallOutComeViewController.m
//  Angel Politics
//
//  Created by Francisco on 8/10/13.
//  Copyright (c) 2013 angelpolitics. All rights reserved.
//

#import "APMCallOutComeViewController.h"
#import "APMCallViewController.h"
#import "ModalPickerView.h"
#import "APMLeadsModel.h"
#import "APMDetailModel.h"

@interface APMCallOutComeViewController (){
    
    CGFloat ymainView;
    
}

@property(nonatomic,strong)NSArray *callStatus;
@property(nonatomic,strong) NSArray *pledge;


@end

@implementation APMCallOutComeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ymainView=self.mainCallOutUIView.frame.origin.y;
    
    // Do any additional setup after loading the view from its nib.
    
   self.callStatus=@[@"Pending",@"Busy",@"No Answer",@"Voicemail",@"Wrong Number"];
    
    self.pledge=@[@"Volunteer",@"Pledge",@"Events",@"Credit card payments",@"Will not donate now",@"Will not donate ever"];
    
    
    self.amountPledgeTextField.delegate=self;
    
    self.nameLabel.text=[NSString stringWithFormat:@"%@ %@",self.detailModel.name,self.detailModel.lastName];
    self.askLabel.text=self.detailModel.ask;
    self.bestLabel.text=self.detailModel.best;
    self.averageLabel.text=self.detailModel.average;
    self.cityAndStateLabel.text=[NSString stringWithFormat:@"%@, %@",self.detailModel.city,self.detailModel.state];
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callStatusButton:(id)sender {
    
    ModalPickerView *pickerView=[[ModalPickerView alloc]initWithValues:self.callStatus];
    
    [pickerView presentInView:self.view withBlock:^(BOOL madeChoice) {
        NSLog(@"Made choice? %d", madeChoice);
        NSLog(@"Selected value: %@", pickerView.selectedValue);
        
        self.callStatusTextField.text=pickerView.selectedValue;
        
    }];

    
}

- (IBAction)pledgeButton:(id)sender {
    
    
    ModalPickerView *pickerView=[[ModalPickerView alloc]initWithValues:self.pledge];
    
    [pickerView presentInView:self.view withBlock:^(BOOL madeChoice) {
        NSLog(@"Made choice? %d", madeChoice);
        NSLog(@"Selected value: %@", pickerView.selectedValue);
        
        self.pledgeTextField.text=pickerView.selectedValue;
        
    }];
}

- (IBAction)dialButton:(id)sender {
    
    APMCallViewController *apmCallVC=[[APMCallViewController alloc]init];
    
    [self.view addSubview:apmCallVC.view];
    [self addChildViewController:apmCallVC];
    [apmCallVC didMoveToParentViewController:self];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    if (textField==self.amountPledgeTextField) {
        
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.mainCallOutUIView.frame=CGRectMake(self.mainCallOutUIView.frame.origin.x
                                                    , -200.0f,self.mainCallOutUIView.frame.size.width , self.mainCallOutUIView.frame.size.height);
            
            
            
        } completion:nil];
        
}
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.mainCallOutUIView.frame=CGRectMake(self.mainCallOutUIView.frame.origin.x
                                                , ymainView,self.mainCallOutUIView.frame.size.width , self.mainCallOutUIView.frame.size.height);
        
        [self.amountPledgeTextField resignFirstResponder];
        
    } completion:nil];
    
    return YES;
    
}

@end
