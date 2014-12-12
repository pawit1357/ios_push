//
//  ViewController.h
//  PushNoti
//
//  Created by GOKIRI on 4/21/56 BE.
//  Copyright (c) 2556 datalatte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisteredTokentID.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

//SubController
#import "ContentViewController.h"
#import "TeamViewController.h"
#import "MessageViewController.h"

#import "UpdateRequestPath.h"
//NSCustom
#import "NSCustomTabbarController.h"


@interface ViewController : UIViewController<LoginViewControllerDelegate,RegisterViewControllerDelegate,UIAlertViewDelegate,
ContentViewControllerDelegate,TeamViewControllerDelegate,MessageViewControllerDelegate,UpdateRequestPathDelegate>{
 
    
    
    NSString *tokent_id;
    
    RegisteredTokentID *rTokent;
    
    //ViewController
    LoginViewController *_loginViewController;
    RegisterViewController *_registerViewController;
    UINavigationController *nav_controller;
    
    
    NSCustomTabbarController *tabController;
    ContentViewController *_contentController;
    TeamViewController *_teamController;
    MessageViewController *_messageController;
    
    UpdateRequestPath *updatePath;
    
}


@property(nonatomic,retain)NSString *tokent_id;

-(IBAction)registerDevice:(id)sender;
-(void)startStageWithController;
-(void)initial;
-(void)render;
@end
