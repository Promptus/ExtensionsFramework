//
//  PPWebBrowserViewController.h
//  MSSNGR
//
//  Created by Lars Kuhnt on 29.01.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPWebBrowserViewController : UIViewController <UIWebViewDelegate, NSURLConnectionDelegate> {
  IBOutlet UIWebView *       webView;
  IBOutlet UIBarButtonItem * closeButton;
  IBOutlet UIBarButtonItem * actionButton;
  IBOutlet UIBarButtonItem * backButton;
  IBOutlet UIBarButtonItem * forwardButton;
  IBOutlet UINavigationBar * navigationBar;
  IBOutlet UIToolbar *       toolbar;
  
}

@property (nonatomic, strong) NSString * urlString;
@property (nonatomic, strong) UIColor * tintColor;
@property (nonatomic, strong) UIColor * titleColor;

+ (id)webViewControllerWithURLString:(NSString*)urlString;

- (id)initWebViewControllerWithURLString:(NSString*)urlString;

- (IBAction)closeButtonClicked:(id)sender;
- (IBAction)actionButtonClicked:(id)sender;
- (IBAction)backButtonClicked:(id)sender;
- (IBAction)forwardButtonClicked:(id)sender;

@end
