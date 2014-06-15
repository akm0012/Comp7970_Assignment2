//  Author: Andrew K. Marshall
//  Last Revision: 6/15/14
//  COMP 7970: Assignment 2
//
//  akm0012_ViewController.m
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
    
    // Get the float values from the user
    float loan_amt = [self.loan_amt_textField.text floatValue];
    float num_payments = [self.num_payment_textField.text floatValue];
    float interest_rate = [self.interest_rate_textField.text floatValue];
    float ballon_pmt = [self.ballon_pmt_textField.text floatValue];
    
    // Make sure the values are valid
    if (loan_amt < 0) {
        NSString *loan_amt_error = @"The loan amount must be positive.";
        [self show_input_alert:loan_amt_error];
        return;
    }
    
    else if (num_payments <= 0) {
        NSString *loan_amt_error = @"The number of payments must be greater than 0.";
        [self show_input_alert:loan_amt_error];
        return;
    }
    
    else if (interest_rate < 0 || interest_rate > 100) {
        NSString *loan_amt_error = @"The interest rate must be in the range of 0 and 100.";
        [self show_input_alert:loan_amt_error];
        return;
    }
    
    else if (ballon_pmt < 0) {
        NSString *loan_amt_error = @"The ballon payment amount must be positive.";
        [self show_input_alert:loan_amt_error];
        return;
    }
    
    // If any fields were left blank, we put 0 in them (if applicable).
    if (loan_amt == 0) {
        self.loan_amt_textField.text = @"0";
    }
    if (interest_rate == 0) {
        self.interest_rate_textField.text = @"0";
    }
    if (ballon_pmt == 0) {
        self.ballon_pmt_textField.text = @"0";
    }
    
    // Convert the interest rate to a decimal value
    interest_rate = interest_rate / 100;
    
    // Calculate the payment amount
    float payment_amount_float = [self calculate_payment_amt:loan_amt :num_payments :interest_rate :ballon_pmt];
    
    // Format the payment amount
    NSString *payment_display_text = [NSString stringWithFormat:@"%.02f", payment_amount_float];
    
    self.payment_display_label.text = payment_display_text;
    
}

- (float)calculate_payment_amt:(float)loan_amt_in :(float)num_payments_in :(float)interest_rate_in :(float)ballon_pmt_in {
    
    // Solving for: (1 + i)^N
    float term_1 = powf((1 + interest_rate_in), num_payments_in);
    
    // Solving for: B / (1+i)^N
    float term_2 = ballon_pmt_in / term_1;
    
    // Solving for: L - (B / (1+i)^N) - aka The final numerator
    float numerator = loan_amt_in - term_2;
    
    // Solving for the denomenator
    float denomenator = 0;
    
    for (int k = 1; k <= num_payments_in; k++) {
        
        denomenator = denomenator + (1 / powf(1 + interest_rate_in, (float) k));
        
    }
    
    float final_payment = numerator / denomenator;

    return final_payment;
}

- (void)doLayoutForOrientation:(UIInterfaceOrientation) orientation {
    
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        [self layoutPortrait];
    }
    
    else {
        [self layoutLandscape];
    }
    
}

- (void) show_input_alert:(NSString*) msg_in {
    
    NSString *alertTitleString = @"Input Error, try again!";
    NSString *alertCancelString = @"OK";
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: alertTitleString
                          message: msg_in
                          delegate: self
                          cancelButtonTitle: alertCancelString
                          otherButtonTitles:nil];
    [alert show];

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
    
    CGFloat button_y = CGRectGetHeight(bounds) / 2 + 20;
    
    self.calculate_button.frame = CGRectMake(button_x, button_y, buttonWidth, buttonHeight);
    
    // The Payment Amount Label
    
    self.payment_amount_label.frame = CGRectMake(label_x, 4.5 * spacing + 47 * 6, label_width * 2, label_height);
    
    self.payment_display_label.frame = CGRectMake(label_x + 150, 4.5 * spacing + 48 * 6, label_width, label_height - 20);


}

- (void) layoutLandscape {
    
    CGRect bounds = self.view.bounds;
    
    // The title - "Loan Payment Calculator"
    CGFloat title_label_width = CGRectGetWidth(bounds) - (2 * spacing);
    CGFloat title_label_height = label_height;
    
    CGFloat title_x = (CGRectGetWidth(bounds) / 2) - 90;
    
    self.title_label.frame = CGRectMake(title_x, spacing, title_label_width, title_label_height);
    
    // X values for the 2 left labels
    CGFloat label_x = spacing;
   
    // X values for the 2 right labels
    CGFloat label_x_col_2 = spacing * 14.5;
    
    // The data input labels
    CGFloat label_width = CGRectGetWidth(bounds) / 3;
    
    // Label - "Loan Amt"
    self.loan_amt_label.frame = CGRectMake(label_x, 4.5 * spacing - 25, label_width, label_height);
    
    // Label - "# Payments"
    self.num_payment_label.frame = CGRectMake(label_x, 4.5 * spacing + 47 - 25, label_width, label_height);
    
    // Label - "Interest Rate"
    self.interest_rate_label.frame = CGRectMake(label_x_col_2, 4.5 * spacing - 25, label_width, label_height);
    
    // Label - "Ballon Pmt"
    self.ballon_pmt_label.frame = CGRectMake(label_x_col_2, 4.5 * spacing + 47 - 25, label_width, label_height);
    
    // The data input text fields
    
    // X values for the 2 left text fields
    CGFloat text_field_x = 5.8 * spacing;
    
    // X values for the 2 right text fields
    CGFloat text_field_x_col_2 = 20 * spacing;
    
    CGFloat text_field_width = CGRectGetWidth(bounds) / 3.6;
    
    self.loan_amt_textField.frame = CGRectMake(text_field_x, 5 * spacing - 25, text_field_width, text_field_height);
    
    self.num_payment_textField.frame = CGRectMake(text_field_x, 5 * spacing + 47 - 25, text_field_width, text_field_height);
    
    self.interest_rate_textField.frame = CGRectMake(text_field_x_col_2, 5 * spacing - 25, text_field_width, text_field_height);
    
    self.ballon_pmt_textField.frame = CGRectMake(text_field_x_col_2, 5 * spacing + 47 - 25, text_field_width, text_field_height);
    
    // The "Calculate" button
    
    CGFloat button_x = CGRectGetWidth(bounds) / 2 - buttonWidth + 30;
    
    CGFloat button_y = CGRectGetHeight(bounds) / 2 + 15;
    
    self.calculate_button.frame = CGRectMake(button_x, button_y, buttonWidth, buttonHeight);
    
    // The Payment Amount Label
    
    CGFloat payment_label_x = spacing * 5;
    
    self.payment_amount_label.frame = CGRectMake(payment_label_x, 4.5 * spacing + 47 * 3.5 - 25, label_width * 2, label_height);
    
    self.payment_display_label.frame = CGRectMake(payment_label_x + 150, 4.5 * spacing + 48 * 3.6 - 25, label_width, label_height - 20);
    
}

- (IBAction)backgroundTap:(id)sender {
    [self.loan_amt_textField resignFirstResponder];
    [self.num_payment_textField resignFirstResponder];
    [self.interest_rate_textField resignFirstResponder];
    [self.ballon_pmt_textField resignFirstResponder];
}

@end
