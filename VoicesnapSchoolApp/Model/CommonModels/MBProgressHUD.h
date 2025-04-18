//
//  MBProgressHUD.h
//  Version 0.4
//  Created by Matej Bukovinski on 2.4.09.
//

// This code is distributed under the terms and conditions of the MIT license. 

// Copyright (c) 2011 Matej Bukovinski
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

@protocol MBProgressHUDDelegate;

/////////////////////////////////////////////////////////////////////////////////////////////

typedef enum {
    /** Progress is shown using an UIActivityIndicatorView. This is the default. */
    MBProgressHUDModeIndeterminate,
    /** Progress is shown using a MBRoundProgressView. */
	MBProgressHUDModeDeterminate,
	/** Shows a custom view */
	MBProgressHUDModeCustomView
} MBProgressHUDMode;

typedef enum {
    /** Opacity animation */
    MBProgressHUDAnimationFade,
    /** Opacity + scale animation */
    MBProgressHUDAnimationZoom
} MBProgressHUDAnimation;

/////////////////////////////////////////////////////////////////////////////////////////////


@interface MBProgressHUD : UIView {
	
	MBProgressHUDMode mode;
    MBProgressHUDAnimation animationType;
	
	SEL methodForExecution;
	id targetForExecution;
	id objectForExecution;
	BOOL useAnimation;
	
    float yOffset;
    float xOffset;
	
	float width;
	float height;
	
	CGSize minSize;
	BOOL square;
	
	float margin;
	
	BOOL dimBackground;
	
	BOOL taskInProgress;
	float graceTime;
	float minShowTime;
	NSTimer *graceTimer;
	NSTimer *minShowTimer;
	NSDate *showStarted;
	
	UIView *indicator;
	UILabel *label;
	UILabel *detailsLabel;
	
	float progress;
	
#if __has_feature(objc_arc_weak)
	id<MBProgressHUDDelegate> __weak delegate;
#elif __has_feature(objc_arc)
	id<MBProgressHUDDelegate> __unsafe_unretained delegate;
#else
	id<MBProgressHUDDelegate> delegate;
#endif
    NSString *labelText;
	NSString *detailsLabelText;
	float opacity;
	UIFont *labelFont;
	UIFont *detailsLabelFont;
	
    BOOL isFinished;
	BOOL removeFromSuperViewOnHide;
	
	UIView *customView;
	
	CGAffineTransform rotationTransform;
}


+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;


+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;


- (id)initWithWindow:(UIWindow *)window;


- (id)initWithView:(UIView *)view;


#if __has_feature(objc_arc)
@property (strong) UIView *customView;
#else
@property (retain) UIView *customView;
#endif


@property (assign) MBProgressHUDMode mode;


@property (assign) MBProgressHUDAnimation animationType;


#if __has_feature(objc_arc_weak)
@property (weak) id<MBProgressHUDDelegate> delegate;
#elif __has_feature(objc_arc)
@property (unsafe_unretained) id<MBProgressHUDDelegate> delegate;
#else
@property (assign) id<MBProgressHUDDelegate> delegate;
#endif


@property (copy) NSString *labelText;


@property (copy) NSString *detailsLabelText;


@property (assign) float opacity;


@property (assign) float xOffset;


@property (assign) float yOffset;


@property (assign) float margin;


@property (assign) BOOL dimBackground;


@property (assign) float graceTime;



@property (assign) float minShowTime;


@property (assign) BOOL taskInProgress;


@property (assign) BOOL removeFromSuperViewOnHide;


#if __has_feature(objc_arc)
@property (strong) UIFont* labelFont;
#else
@property (retain) UIFont* labelFont;
#endif


#if __has_feature(objc_arc)
@property (strong) UIFont* detailsLabelFont;
#else
@property (retain) UIFont* detailsLabelFont;
#endif

/** 
 * The progress of the progress indicator, from 0.0 to 1.0. Defaults to 0.0. 
 */
@property (assign) float progress;

/**
 * The minimum size of the HUD bezel. Defaults to CGSizeZero.
 */
@property (assign) CGSize minSize;

/**
 * Force the HUD dimensions to be equal if possible. 
 */
@property (assign, getter = isSquare) BOOL square;


- (void)show:(BOOL)animated;


- (void)hide:(BOOL)animated;


- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;


- (void)showWhileExecuting:(SEL)method onTarget:(id)target withObject:(id)object animated:(BOOL)animated;

@end

/////////////////////////////////////////////////////////////////////////////////////////////

@protocol MBProgressHUDDelegate <NSObject>

@optional

/** 
 * Called after the HUD was fully hidden from the screen. 
 */
- (void)hudWasHidden:(MBProgressHUD *)hud;

/**
 * @deprecated use hudWasHidden: instead
 * @see hudWasHidden:
 */
- (void)hudWasHidden __attribute__ ((deprecated)); 

@end

/////////////////////////////////////////////////////////////////////////////////////////////

/**
 * A progress view for showing definite progress by filling up a circle (pie chart).
 */
@interface MBRoundProgressView : UIView {
@private
    float _progress;
}

/**
 * Progress (0.0 to 1.0)
 */
@property (nonatomic, assign) float progress;

@end

/////////////////////////////////////////////////////////////////////////////////////////////

