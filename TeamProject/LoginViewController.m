//
//  LoginViewController.m
//  TeamProject
//
//  Created by SDT-1 on 2014. 2. 13..
//  Copyright (c) 2014년 hongik. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (IBAction)Login:(id)sender {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"isTest": @"1",
                             @"userId": @"4"};
    [manager POST:@"http://picple.pws12321.cloulu.com/login/" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}
//

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
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
