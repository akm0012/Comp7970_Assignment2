//
//  akm0012_ViewController.m
//  Assignment 2
//
//  Created by Andrew Marshall on 6/11/14.
//  Copyright (c) 2014 Comp_7970_akm0012. All rights reserved.
//

#import "akm0012_ViewController.h"

@interface akm0012_ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *loan_amt_label;
@property (weak, nonatomic) IBOutlet UITextField *loan_amt_textField;
@property (weak, nonatomic) IBOutlet UILabel *num_payment_label;
@property (weak, nonatomic) IBOutlet UITextField *num_payment_textField;
@property (weak, nonatomic) IBOutlet UILabel *interest_rate_label;
@property (weak, nonatomic) IBOutlet UITextField *interest_rate_textField;
@property (weak, nonatomic) IBOutlet UILabel *ballon_pmt_label;
@property (weak, nonatomic) IBOutlet UITextField *ballon_pmt_textField;
@property (weak, nonatomic) IBOutlet UIButton *calculate_button;
@property (weak, nonatomic) IBOutlet UILabel *payment_amount_label;
@property (weak, nonatomic) IBOutlet UILabel *payment_display_label;
- (IBAction)calculate_button_pressed:(UIButton *)sender;

@end

@implementation akm0012_ViewController

// Constants
static const CGFloat buttonHeight = 40;
static const CGFloat buttonWidth = 120;
static const CGFloat spacing = 20;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIApplication *app = [UIApplication sharedApplication];
    UIInterfaceOrientation current_orientation = app.statusBarOrientation;
    [self doLayoutForOrientation:current_orientation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    [self doLayoutForOrientation:toInterfaceOrientation];
}

- (IBAction)calculate_button_pressed:(UIButton *)sender {
}

- (void)doLayoutForOrientation:(UIInterfaceOrientation) orientation {
    
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        [self layoutPortrait];
    }
    
    else {
        [self layoutLandscape];
    }
    
}

- (void) layoutPortrait {
    
    
}

- (void) layoutLandscape {
    
    
}



@end
