//
//  ViewController.m
//  QuadrangleTriangleForOpenGL
//
//  Created by tongle on 2017/8/22.
//  Copyright © 2017年 tong. All rights reserved.
//

#import "ViewController.h"
#import "QuadrangleViewController.h"
#import "TriangleViewController.h"

@interface ViewController ()
- (IBAction)TriangleOpenGL:(id)sender;
- (IBAction)QuadrangleOpenGL:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)TriangleOpenGL:(id)sender {
    TriangleViewController * view = [[TriangleViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}
- (IBAction)QuadrangleOpenGL:(id)sender {
    QuadrangleViewController * view = [[QuadrangleViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}
@end
