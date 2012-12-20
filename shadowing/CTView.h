//
//  CTView.h
//  shadowing
//
//  Created by silvon on 12-12-3.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface CTView : UIScrollView<UIScrollViewDelegate>


- (void) refreshWithArrstring:(NSAttributedString *) string;
- (void) refreshWithArrstring:(NSAttributedString *) string andImage:(UIImage*)img;

@end
