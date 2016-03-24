//
//  SliderBarTagView.m
//  wowProduct
//
//  Created by AllenShiu on 3/24/16.
//  Copyright © 2016 AllenShiu. All rights reserved.
//

#import "SliderBarTagView.h"
#import <objc/runtime.h>
@interface SliderBarTagView()

@property (nonatomic,strong)ScrollBlock scrollBlock;
@property (nonatomic,strong)UISlider *sliderView;
@property (nonatomic,strong)UIView *tagView;
@property (nonatomic,strong)UIImageView *sliderViewBarImageView;
@property (nonatomic, assign) BOOL isStopHiddenAnimation;
@property (nonatomic, assign) BOOL isAnimation;

@end

@implementation SliderBarTagView

+(void)initWithSliderView:(UISlider *)sliderView withTagView:(UIView*)tagView didScoroll:(ScrollBlock)scrollblock{
    if (!objc_getAssociatedObject(sliderView, _cmd)) {
        SliderBarTagView *sliderBarTagView = [SliderBarTagView new];
        sliderBarTagView.sliderView = sliderView;
        sliderBarTagView.tagView = tagView;
        sliderBarTagView.sliderViewBarImageView = sliderView.subviews.lastObject;
        sliderBarTagView.scrollBlock = scrollblock;
        sliderBarTagView.tagView.alpha=0.0f;
        sliderBarTagView.isAnimation = NO;
        CGRect newFrame = tagView.frame;
        CGFloat fixedSpace = sliderView.frame.origin.y - CGRectGetHeight(tagView.frame);
        newFrame.origin.y = fixedSpace + 30;
        tagView.frame = newFrame;
        
        [sliderBarTagView.sliderViewBarImageView addObserver:sliderBarTagView forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        [sliderBarTagView.sliderView addObserver:sliderBarTagView forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
        [sliderView.superview addSubview:sliderBarTagView.tagView];

        objc_setAssociatedObject(sliderView, _cmd, sliderBarTagView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"frame"]) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(tagViewHideAnimation) object:nil];
        [self performSelector:@selector(tagViewHideAnimation) withObject:nil afterDelay:0.5];
        [self showLabel];
    }else if([keyPath isEqualToString:@"value"]){
        [self performSelector:@selector(tagViewShowAnimation) withObject:nil afterDelay:0];
    }
    [self convertFrame];
}

- (CGRect)tagViewFrameToShow:(BOOL)isShow {
    CGRect newFrame = self.tagView.frame;
    CGFloat fixedSpace = self.sliderView.frame.origin.y - CGRectGetHeight(self.tagView.frame);
    if (isShow) {
        newFrame.origin.y = fixedSpace - 30;
    }
    else {
        newFrame.origin.y =  fixedSpace + 30;
    }
    return newFrame;
}

-(void)tagViewShowAnimation{
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations: ^{
            self.tagView.alpha = 1.0f;
            self.tagView.frame = [self tagViewFrameToShow:YES];
        } completion: ^(BOOL finished) {
        }];
}

-(void)tagViewHideAnimation{
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations: ^{
            self.tagView.alpha = 0.0f;
            self.tagView.frame = [self tagViewFrameToShow:NO];
        } completion: ^(BOOL finished) {
        }];
}

-(void)showLabel{
    self.scrollBlock(self,self.tagView);
}

-(void)convertFrame{
    CGPoint barImgViewConvertPoint = [self.sliderView convertPoint:self.sliderViewBarImageView.frame.origin toView:self.sliderView.superview];
    CGRect newFrame = self.tagView.frame;
    
    CGFloat bothCenterX = (CGRectGetWidth(self.sliderViewBarImageView.frame) - CGRectGetWidth(self.tagView.frame)) / 2.0f;
    CGFloat tagViewX = barImgViewConvertPoint.x + bothCenterX;
    newFrame.origin.x = tagViewX;
    self.tagView.frame = newFrame;
}
-(void)dealloc{
    [self.sliderViewBarImageView removeObserver:self forKeyPath:@"frame"];
    [self.sliderView removeObserver:self forKeyPath:@"value"];
}

@end
