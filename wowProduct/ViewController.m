//
//  ViewController.m
//  wowProduct
//
//  Created by AllenShiu on 3/24/16.
//  Copyright © 2016 AllenShiu. All rights reserved.
//

#import "ViewController.h"
#import "SliderBarTagView.h"
#import "TagView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISlider *sliderView;
@property (strong,nonatomic) TagView *tagView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewDidAppear:(BOOL)animated{
    self.tagView = [[TagView alloc] init];
    [SliderBarTagView initWithSliderView:self.sliderView withTagView:self.tagView didScoroll:^(id sliderBarTagView, TagView * tagView) {
    }];
}
- (IBAction)sliderValueChang:(id)sender {
    self.tagView.displayLabel.text = [NSString stringWithFormat:@"%f",self.sliderView.value];
}
@end
