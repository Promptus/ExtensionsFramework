//
//  PPWebBrowserViewController.m
//  MSSNGR
//
//  Created by Lars Kuhnt on 29.01.14.
//  Copyright (c) 2014 Promptus. All rights reserved.
//

#import "PPWebBrowserViewController.h"
#import "NSString+Extensions.h"

@interface PPWebBrowserViewController ()

@end

@implementation PPWebBrowserViewController

@synthesize urlString;
@synthesize tintColor;
@synthesize titleColor;

+ (id)webViewControllerWithURLString:(NSString *)urlString {
  return [[PPWebBrowserViewController alloc] initWebViewControllerWithURLString:urlString];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
      
  }
  return self;
}

- (id)initWebViewControllerWithURLString:(NSString *)_urlString {
  NSBundle *resourceBundle = [NSBundle bundleForClass:[self class]];
  if (self = [super initWithNibName:@"PPWebBrowserViewController" bundle:resourceBundle]) {
    _urlString = [_urlString ce_urlStringUsingEncoding:NSUTF8StringEncoding];
    if ([_urlString hasPrefix:@"http://"] || [_urlString hasPrefix:@"https://"]) {
      self.urlString = _urlString;
    } else {
      self.urlString = [NSString stringWithFormat:@"http://%@", _urlString];
    }
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  webView.navigationDelegate = self;
  navigationBar.topItem.title = self.urlString;
  UIColor * _tintColor = tintColor ? tintColor : [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
  if (titleColor) {
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: titleColor};
  }
  if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] == NSOrderedAscending) {
    navigationBar.tintColor = _tintColor;
    toolbar.tintColor = _tintColor;
  } else {
    navigationBar.barTintColor = _tintColor;
    toolbar.barTintColor = _tintColor;
  }
  NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
  [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning{
  [super didReceiveMemoryWarning];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
  return UIStatusBarStyleLightContent;
}

- (IBAction)closeButtonClicked:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionButtonClicked:(id)sender {
  [[UIApplication sharedApplication] openURL:webView.URL options:@{} completionHandler:nil];
}

- (IBAction)backButtonClicked:(id)sender {
  if ([webView canGoBack])
    [webView goBack];
}

- (IBAction)forwardButtonClicked:(id)sender {
  if ([webView canGoForward])
    [webView goForward];
}

#pragma mark WKNavigationDelegate

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    __weak PPWebBrowserViewController *weakSelf = self;
    [webView evaluateJavaScript:@"document.title" completionHandler:^(NSString *result, NSError *error) {
        PPWebBrowserViewController *strongSelf = weakSelf;
        [strongSelf setupNavigationBarTitle: result];
    }];
    
    backButton.enabled = [webView canGoBack];
    forwardButton.enabled = [webView canGoForward];
}

-(void)setupNavigationBarTitle:(NSString *)title {
    navigationBar.topItem.title = title;
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void)setTintColor:(UIColor *)_tintColor {
  tintColor = _tintColor;
  navigationBar.tintColor = _tintColor;
  toolbar.tintColor = _tintColor;
}

-(void)setTitleColor:(UIColor *)_titleColor {
  titleColor = _titleColor;
  navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: _titleColor};
}

@end
