//
//  TagView.m
//  wowProduct
//
//  Created by AllenShiu on 3/24/16.
//  Copyright © 2016 AllenShiu. All rights reserved.
//

#import "TagView.h"

@implementation TagView

-(id)init{
    if (self = [super init]) {
        NSArray *arrayOfViews = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        self =arrayOfViews[0];
    }
    
    return self;
}


-(id)initForomXib{
    NSArray *arrayOfViews = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    self =arrayOfViews[0];
    if (self) {
    
    }
    return self;
}

@end