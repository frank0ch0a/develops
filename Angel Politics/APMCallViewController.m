//
//  APMCallViewController.m
//  Angel Politics
//
//  Created by Francisco on 28/10/13.
//  Copyright (c) 2013 angelpolitics. All rights reserved.
//

#import "APMCallViewController.h"
#import "APMAppDelegate.h"
#import "APMPhone.h"
#import "APMCallOutComeViewController.h"
#import  "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "SVProgressHUD.h"

@interface APMCallViewController (){
    
    NSOperationQueue *queue;
    
    CGFloat ypledge;
}


@end

@implementation APMCallViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        queue=[[NSOperationQueue alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.callAmountTextField.delegate=self;
    self.emailCallTextField.delegate=self;
    self.psCallTextField.delegate=self;
    self.detailsCallTextField.delegate=self;
    
   
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //Hacemos Diseño a la vista pop
    self.callingUIView.layer.borderColor=[UIColor whiteColor].CGColor;
    self.callingUIView.layer.borderWidth=3.0f;
    self.callingUIView.layer.cornerRadius=10.0f;
    
    UIImage *imageButton=[[UIImage imageNamed:@"btn_login_up"]stretchableImageWithLeftCapWidth:6 topCapHeight:0];
    
    [self.callPledgeButton setBackgroundImage:imageButton forState:UIControlStateNormal];
    
    ypledge=self.callingUIView.frame.origin.y;

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)closeCallVC:(id)sender {
    
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
    APMCallOutComeViewController *callOut=[[APMCallOutComeViewController alloc]init];
    
    [self.navigationController pushViewController:callOut animated:YES];
    

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    [UIView animateWithDuration:0.25 delay:0
                        options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            
                            self.callingUIView.frame=CGRectMake(self.callingUIView.frame.origin.x, ypledge, self.callingUIView.frame.size.width, self.callingUIView.frame.size.height);
                            
                            
                            self.closeButtonOutlet.hidden=NO;
                        } completion:nil];
    
    
    return YES;
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    if (textField==self.callAmountTextField) {
        [UIView animateWithDuration:0.25 delay:0
                            options:UIViewAnimationOptionCurveEaseOut animations:^{
                                
                                
                                self.callingUIView.frame=CGRectMake(self.callingUIView.frame.origin.x, -40, self.callingUIView.frame.size.width, self.callingUIView.frame.size.height);
                                
                                self.closeButtonOutlet.hidden=YES;
                                
                            } completion:nil];
        

    }else if(textField== self.psCallTextField) {
    
    [UIView animateWithDuration:0.25 delay:0
                        options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            
                            self.callingUIView.frame=CGRectMake(self.callingUIView.frame.origin.x, -120, self.callingUIView.frame.size.width, self.callingUIView.frame.size.height);
                            
                            self.closeButtonOutlet.hidden=YES;
                            
                        } completion:nil];

    
    
    }
    
}

- (IBAction)callPledgeButtonAct:(id)sender {
    
     [SVProgressHUD show];
    
    [UIView animateWithDuration:0.25 delay:0
                        options:UIViewAnimationOptionCurveEaseOut animations:^{
                            
                            
                            self.callingUIView.frame=CGRectMake(self.callingUIView.frame.origin.x, ypledge, self.callingUIView.frame.size.width, self.callingUIView.frame.size.height);
                            
                            
                            
                        } completion:nil];
    
    NSDictionary *dict=@{@"email":self.emailCallTextField.text ,@"canid":self.candID,@"donorid":self.donorID,@"pledge":self.callAmountTextField.text};
    
    NSLog(@"Parameters %@",dict);
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://www.angelpolitics.com"]];
    
    [httpClient setDefaultHeader:@"Content-Type" value:@"application/json"];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"/mobile/outcome.php"
                                                      parameters:dict
                                    ];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        if (JSON !=nil) {
            
            [SVProgressHUD dismiss];
            NSLog(@"Resulta JSON MenuVC %@",JSON);
            
        
            
            
        }else{
            

            
            
            
            
        }
        
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error %@", [error description]);
        
    }];
    
    operation.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/html", nil];
    
    
    
    
    [queue addOperation:operation];
    
    
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
    
}
@end
