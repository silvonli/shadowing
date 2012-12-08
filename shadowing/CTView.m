//
//  CTView.m
//  shadowing
//
//  Created by silvon on 12-12-3.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import "CTView.h"
#import "layoutConstant.h"

@interface CTView ()
@property(nonatomic, strong) NSAttributedString* attString;
@property(nonatomic, strong) UIImage * illustration;
@end
@implementation CTView

@synthesize attString = _attString;
@synthesize illustration = _illustration;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (void) refreshWithArrstring:(NSAttributedString *) string andImage:(UIImage*)img
{
    self.attString = string;
    self.illustration = img;
    [self setNeedsDisplay];
}
- (void) refreshWithArrstring:(NSAttributedString *) string
{
    self.attString = string;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect textBounds = CGRectInset(self.bounds, FRAME_X_OFFSET, FRAME_Y_OFFSET);
    CGRect imgBounds= CGRectMake(ILLUSTRATION_X_ORIGIN, ILLUSTRATION_Y_ORIGIN, ILLUSTRATION_WIDTH, ILLUSTRATION_HEIGHT);
    CGPathMoveToPoint(path, NULL, CGRectGetMaxX(textBounds), CGRectGetMaxY(textBounds));
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(textBounds), CGRectGetMaxY(textBounds));
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(textBounds), CGRectGetMinY(textBounds));
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(textBounds), CGRectGetMinY(textBounds));
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(imgBounds), CGRectGetMinY(imgBounds));
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(imgBounds), CGRectGetMinY(imgBounds));
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(imgBounds), CGRectGetMaxY(imgBounds));
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(imgBounds), CGRectGetMaxY(imgBounds));
    CGPathCloseSubpath(path);
    
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self.attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, self.attString.length), path, NULL);
    CTFrameDraw(frame, context); 
    CFRelease(frame); 
    CFRelease(path);
    CFRelease(framesetter);
    
    CGContextDrawImage(context, imgBounds, self.illustration.CGImage);
}


@end
