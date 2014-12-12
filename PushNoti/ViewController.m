//
//  ViewController.m
//  PushNoti
//
//  Created by GOKIRI on 4/21/56 BE.
//  Copyright (c) 2556 datalatte. All rights reserved.
//

#import "ViewController.h"
#import "UserListObject.h"
#import "DataManagement.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tokent_id;

-(void)viewDidAppear:(BOOL)animated{
    
    }

-(void)checkStage{
    
    if( [[[DataManagement DatabaseManagement] getUserData] count] == 0){
        
        
    }else{
        [nav_controller popViewControllerAnimated:NO];
        [self startStageWithController];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //rTokent = [[RegisteredTokentID alloc]init];
    
   
    [self initial];
    [self render];
    
    
    [self performSelector:@selector(checkStage) withObject:self afterDelay:1.0];


}

-(void)initial{
    
    self.tokent_id = [self.tokent_id stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.tokent_id = [self.tokent_id stringByReplacingOccurrencesOfString:@"<" withString:@""];
    self.tokent_id = [self.tokent_id stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    if([UIScreen mainScreen].bounds.size.height == 568){
    
    _loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    _loginViewController.delegate = self;
    _loginViewController.toket_id = self.tokent_id;

    }else{
        //LoginViewController4xsize
        _loginViewController = [[LoginViewController alloc]initWithNibName:@"LoginViewController4xsize" bundle:nil];
        _loginViewController.delegate = self;
        _loginViewController.toket_id = self.tokent_id;

    }
    
    nav_controller = [[UINavigationController alloc]initWithRootViewController:_loginViewController];
    nav_controller.navigationBarHidden = YES;
    
    NSLog(@"na %@",_loginViewController.view);
    
    
    updatePath = [[UpdateRequestPath alloc]init];
    updatePath.delegate  =self;
    
}
-(void)render{
    
   
    [self addChildViewController:nav_controller];
    [self.view addSubview:nav_controller.view];
    [nav_controller.view release];
    
    
}
-(IBAction)registerDevice:(id)sender{
    
    
    /*
    self.tokent_id = [self.tokent_id stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.tokent_id = [self.tokent_id stringByReplacingOccurrencesOfString:@"<" withString:@""];
    self.tokent_id = [self.tokent_id stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    [rTokent registerWithTokentID:self.tokent_id];
    */
}

#pragma mark - login delegate
-(void)LoginViewControllerDidRegister:(LoginViewController*)_login{
    
    self.tokent_id = [self.tokent_id stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.tokent_id = [self.tokent_id stringByReplacingOccurrencesOfString:@"<" withString:@""];
    self.tokent_id = [self.tokent_id stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    _registerViewController = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    _registerViewController.delegate =self;
    _registerViewController.tokent_id = self.tokent_id;
    
    [nav_controller pushViewController:_registerViewController animated:YES];
    [_registerViewController release];
    
}
-(void)startStageWithController{
    
    _contentController = [[ContentViewController alloc]initWithNibName:@"ContentViewController" bundle:nil];
    _contentController.delegate = self;
    _teamController = [[TeamViewController alloc]initWithNibName:@"TeamViewController" bundle:nil];
    _teamController.delegate = self;
    _messageController = [[MessageViewController alloc]initWithNibName:@"MessageViewController" bundle:nil];
    _messageController.delegate = self;
    
    //
    
    tabController = [[[NSCustomTabbarController alloc]initWithRootViewController:
                      [NSArray arrayWithObjects:_contentController,_teamController,_messageController, nil]] autorelease];
    
    //tabController.view.transform = CGAffineTransformMakeTranslation(0, 84);
    
    tabController.initRootViewControllerIndex = 0;
    
    //[tabController prepareForAnimation];
    
    
    //[tabController startAnimation];
    
    [nav_controller pushViewController:tabController animated:YES];
    
    [tabController setRootViewController:0];
    
    //[tabController release];

}
-(void)LoginViewController:(LoginViewController*)_login DidFinishedLoginWithUserData:(NSMutableArray*)_userData{
    
    
    NSMutableDictionary *loginData = [[NSMutableDictionary alloc]init];
    [loginData setObject:[[_userData objectAtIndex:0] user_id]  forKey:@"user_id"];
    [loginData setObject:[[_userData objectAtIndex:0] username]  forKey:@"username"];
    [loginData setObject:[[_userData objectAtIndex:0] password]  forKey:@"password"];
    
    
    [[DataManagement DatabaseManagement] saveAsUserData:loginData];
    
    
    [nav_controller popViewControllerAnimated:NO];
    
    [self startStageWithController];
       
    
}


#pragma mark - register delegate
-(void)RegisterViewControllerDidCancelRegistered:(RegisterViewController*)_register{
    
    [nav_controller popViewControllerAnimated:YES];
}
-(void)RegisterViewControllerDidFinishRegistered:(RegisterViewController*)_register{
    
    [nav_controller popToRootViewControllerAnimated:YES];
    
}

#pragma subview Controller delegate
-(void)logout{
    UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"Team Alert"
                                                message:@"Are You Sure? /n To Logout"
                                               delegate:self cancelButtonTitle:@"CANCEL"
                                      otherButtonTitles:@"OK", nil];
    al.delegate = self;
    al.accessibilityIdentifier = @"logout";
    
    [al show];
    [al release];
}
UITextField *pathRequest;
-(void)fixpathContent{
    
    
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Content" message:@"Enter your request path:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        alertView.accessibilityIdentifier = @"request_path";

        pathRequest = [alertView textFieldAtIndex:0];
        [alertView show];
        [alertView release];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if([alertView.accessibilityIdentifier isEqualToString:@"logout"]){
        if(buttonIndex == 0){
        
        }else if(buttonIndex == 1){
            
             [[DataManagement DatabaseManagement] removeUserData];
            
            [nav_controller popViewControllerAnimated:YES];
        }
    }else if([alertView.accessibilityIdentifier isEqualToString:@"request_path"]){
        if(buttonIndex == 0){
            NSLog(@"calcel");
        }else if(buttonIndex == 1){
            
            [updatePath requestPath:pathRequest.text];
            
        }
    }
}
-(void)UpdateRequestPath:(UpdateRequestPath*)_UpdateRequestPath didFinished:(BOOL)_success{
    NSLog(@"update finish");
    [nav_controller popViewControllerAnimated:NO];
    [self startStageWithController];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
