//
//  CSNoteView.m
//  LinedTextView
//
//  Created by Naveed Ahsan on 10/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NoteView.h"


@implementation NoteView

- (id)initWithFrame:(CGRect)frame {
	
    self = [super initWithFrame:frame];
    if (self) {
		[self setBackgroundColor:[UIColor clearColor]];
        self.font = [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:12];
        self.delegate = self;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Set the line color and width
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0f green:0.0f blue:1.0f alpha:1.0f].CGColor);
    CGContextSetLineWidth(context, 1.0f);
    //Start a new Path
    CGContextBeginPath(context);
    
    //Find the number of lines in our textView + add a bit more height to draw lines in the empty part of the view
    NSUInteger numberOfLines = (self.contentSize.height + self.bounds.size.height) / self.font.leading;
    
    //Set the line offset from the baseline. (I'm sure there's a concrete way to calculate this.)
    //CGFloat baselineOffset = 6.0f;
    
    //iterate over numberOfLines and draw each line
    for (int x = 0; x < numberOfLines; x++) {
        //0.5f offset lines up line with pixel boundary
       // [@"سينتابتيسباتسيابتيسبا" sizeWithFont:[UIFont systemFontOfSize:14]].height
        CGContextMoveToPoint(context, self.bounds.origin.x,[@"سينتابتيسباتسيابتيسبا" sizeWithFont:[UIFont systemFontOfSize:16]].height*x + [@"سينتابتيسباتسيابتيسبا" sizeWithFont:[UIFont systemFontOfSize:16]].height/2);
        CGContextAddLineToPoint(context, self.bounds.size.width,[@"سينتابتيسباتسيابتيسبا" sizeWithFont:[UIFont systemFontOfSize:16]].height*x + [@"سينتابتيسباتسيابتيسبا" sizeWithFont:[UIFont systemFontOfSize:16]].height/2);

    }
    
    //Close our Path and Stroke (draw) it
    CGContextClosePath(context);
    CGContextStrokePath(context);}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentSize.height);
  [self setNeedsDisplay];
}

@end
