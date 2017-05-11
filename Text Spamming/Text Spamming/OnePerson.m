//
//  ViewController.m
//  Text Spamming
//
//  Created by Anon on 29/01/2016.
//  Copyright © 2016 Anon. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>
//#import <CoreTelephony/CTCellularData.h>


#import "ViewController.h"
#import "OnePerson.h"


@interface OnePerson ()

@end

@implementation OnePerson
int intMassageTimes;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.MassageNumber.layer.borderWidth = 2.0f;
    self.MassageNumber.layer.borderColor = [[UIColor grayColor] CGColor];
    self.MassageNumber.layer.cornerRadius = 8;
    
    self.MassageTimes.layer.borderWidth = 2.0f;
    self.MassageTimes.layer.borderColor = [[UIColor grayColor] CGColor];
    self.MassageTimes.layer.cornerRadius = 8;
    
    self.MassageBody.layer.borderWidth = 2.0f;
    self.MassageBody.layer.borderColor = [[UIColor grayColor] CGColor];
    self.MassageBody.layer.cornerRadius = 8;
    
    intMassageTimes = [_MassageTimes.text intValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)SendMassage:(id)sender{
    [self SendMultipleTime];
//    [self showSMS];
    
}

-(void)SendMultipleTime{
    for (int x = 0; x <= intMassageTimes; x++) {
        NSLog(@"Nice one");
//        [[CTMessageCenter sharedMessageCenter] sendSMSWithText:@"Your Message here"
//                                                 serviceCenter:nil
//                                                     toAddress:@"Receiver's Phone Number here"];
    }
}


//This is for the text message
- (void)showSMS {
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSArray *recipents = @[self.MassageNumber.text]; //@[@"12345678", @"72345524"];
    NSString *message = [NSString stringWithFormat:@"%@", self.MassageBody.text];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




//Keyboard Hide and show function
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_MassageNumber resignFirstResponder];
    [_MassageTimes resignFirstResponder];
    [_MassageBody resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}


- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    int animatedDistance;
    int moveUpValue = textField.frame.origin.y+ textField.frame.size.height;
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        animatedDistance = 216-(460-moveUpValue-5);
    }
    else
    {
        animatedDistance = 162-(320-moveUpValue-5);
    }
    
    if(animatedDistance>0)
    {
        const int movementDistance = animatedDistance;
        const float movementDuration = 0.3f;
        int movement = (up ? -movementDistance : movementDistance);
        [UIView beginAnimations: nil context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}


@end
