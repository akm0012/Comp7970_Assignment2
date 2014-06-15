//
//  akm0012_ViewController.m
//  Assignment 2
//
//  Created by Andrew Marshall on 6/11/14.
//  Copyright (c) 2014 Comp_7970_akm0012. All rights reserved.
//

#import "akm0012_ViewController.h"

@interface akm0012_ViewController ()
@property (weak, nonatomic) IBOutlet UILabel        *title_label;
@property (weak, nonatomic) IBOutlet UILabel        *loan_amt_label;
@property (weak, nonatomic) IBOutlet UITextField    *loan_amt_textField;
@property (weak, nonatomic) IBOutlet UILabel        *num_payment_label;
@property (weak, nonatomic) IBOutlet UITextField    *num_payment_textField;
@property (weak, nonatomic) IBOutlet UILabel        *interest_rate_label;
@property (weak, nonatomic) IBOutlet UITextField    *interest_rate_textField;
@property (weak, nonatomic) IBOutlet UILabel        *ballon_pmt_label;
@property (weak, nonatomic) IBOutlet UITextField    *ballon_pmt_textField;
@property (weak, nonatomic) IBOutlet UIButton       *calculate_button;
@property (weak, nonatomic) IBOutlet UILabel        *payment_amount_label;
@property (weak, nonatomic) IBOutlet UILabel        *payment_display_label;

- (IBAction)calculate_button_pressed:(UIButton *)sender;

@end

@implementation akm0012_ViewController

// Constants
static const CGFloat buttonHeight = 40;
static const CGFloat buttonWidth = 80;

//static const CGFloat title_label_width = 300;

//static const CGFloat label_height = 60;
static const CGFloat label_height = 50;

static const CGFloat text_field_height = 30;


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
    
    CGRect bounds = self.view.bounds;
    
    // The title - "Loan Payment Calculator"
    CGFloat title_label_width = CGRectGetWidth(bounds) - (2 * spacing);
    CGFloat title_label_height = label_height;
    
    self.title_label.frame = CGRectMake(3.5 * spacing, spacing, title_label_width, title_label_height);

    // X values for the 4 labels
    CGFloat label_x = spacing;
    
    // The data input labels
    CGFloat label_width = CGRectGetWidth(bounds) / 3;
    
    // Label - "Loan Amt"
    self.loan_amt_label.frame = CGRectMake(label_x, 4.5 * spacing, label_width, label_height);
    
    // Label - "# Payments"
    self.num_payment_label.frame = CGRectMake(label_x, 4.5 * spacing + 47, label_width, label_height);

    // Label - "Interest Rate"
    self.interest_rate_label.frame = CGRectMake(label_x, 4.5 * spacing + 47 * 2, label_width, label_height);

    // Label - "Ballon Pmt"
    self.ballon_pmt_label.frame = CGRectMake(label_x, 4.5 * spacing + 47 * 3, label_width, label_height);
    
    // The data input text fields
    
    // X values for the 4 text fields
    CGFloat text_field_x = 6.5 * spacing;
    
    CGFloat text_field_width = CGRectGetWidth(bounds) / 1.9;
    
    self.loan_amt_textField.frame = CGRectMake(text_field_x, 5 * spacing, text_field_width, text_field_height);
    
    self.num_payment_textField.frame = CGRectMake(text_field_x, 5 * spacing + 47, text_field_width, text_field_height);
    
    self.interest_rate_textField.frame = CGRectMake(text_field_x, 5 * spacing + 47 * 2, text_field_width, text_field_height);
    
    self.ballon_pmt_textField.frame = CGRectMake(text_field_x, 5 * spacing + 47 * 3, text_field_width, text_field_height);
    
    // The "Calculate" button
    
    CGFloat button_x = CGRectGetWidth(bounds) / 2 - buttonWidth + 30;
    
    CGFloat button_y = CGRectGetHeight(bounds) / 2 + 40;
    
    self.calculate_button.frame = CGRectMake(button_x, button_y, buttonWidth, buttonHeight);
    
    // The Payment Amount Label
    
    self.payment_amount_label.frame = CGRectMake(label_x, 4.5 * spacing + 47 * 6, label_width * 2, label_height);
    
    self.payment_display_label.frame = CGRectMake(label_x + 150, 4.5 * spacing + 48 * 6, label_width, label_height - 20);


}

- (void) layoutLandscape {
    
    
}



@end
