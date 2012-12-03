//
//  CTView.m
//  shadowing
//
//  Created by silvon on 12-12-3.
//  Copyright (c) 2012年 silvon. All rights reserved.
//

#import "CTView.h"

@implementation CTView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable(); //1
    CGPathAddRect(path, NULL, self.bounds );
    
    //NSAttributedString* attString2 = [[NSAttributedString alloc] initWithString:@"Hello core text world!"]; //2
    
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)CFBridgingRetain(self.attString)); //3
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [self.attString length]), path, NULL);
    
    CTFrameDraw(frame, context); //4
    
    CFRelease(frame); //5
    CFRelease(path);
    CFRelease(framesetter);
}


@end
