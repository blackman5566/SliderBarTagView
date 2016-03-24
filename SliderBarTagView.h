//
//  SliderBarTagView.h
//  wowProduct
//
//  Created by AllenShiu on 3/24/16.
//  Copyright © 2016 AllenShiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void (^ScrollBlock)(id sliderBarTagView, id tagView);

@interface SliderBarTagView : NSObject

+(void)initWithSliderView:(UISlider *)sliderView withTagView:(UIView*)tagView didScoroll:(ScrollBlock)scrollblock;

@end
