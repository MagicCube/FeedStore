//
//  FSFeedDetailViewController.m
//  FeedStore
//
//  Created by Henry Li on 13-5-11.
//  Copyright (c) 2013年 MagicCube. All rights reserved.
//

#import "FSEntryDetailSceneController.h"

@implementation FSEntryDetailSceneController

@synthesize entry = _entry;
@synthesize textView = _textView;
@synthesize titleLabel = _titleLabel;

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

+ (FSEntryDetailSceneController *)sharedInstance
{
    static dispatch_once_t pred;
    static FSEntryDetailSceneController *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[FSEntryDetailSceneController alloc] init];
    });
    return shared;
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = rgbhex(0xf7f7f7);
    self.view.layer.cornerRadius = 3;
    
    _textView = [[DTAttributedTextView alloc] initWithFrame:self.view.bounds];
    _textView.backgroundColor = self.view.backgroundColor;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _textView.shouldDrawImages = NO;
    _textView.scrollEnabled = YES;
    _textView.alwaysBounceVertical = YES;

    int paddingLeft = 10;
    int paddingTop = 10;
    if ([UIDevice currentDevice].isPad)
    {
        paddingLeft = 100;
        paddingTop = 40;
    }
    _textView.contentInset = UIEdgeInsetsMake(paddingTop, paddingLeft, paddingTop, paddingLeft);
    _textView.textDelegate = self;
    [self.view addSubview:_textView];
    
    
    int titleSize = 22;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, paddingLeft, 0, titleSize)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:titleSize];
    _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

- (void)viewDidAppear:(BOOL)animated
{
    if (_entry != nil)
    {
        [self renderEntry:_entry];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.textView.attributedString = [[NSAttributedString alloc] initWithString:@""];
}


- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame;
{
    if (attachment.contentType == DTTextAttachmentTypeImage)
	{
		// if the attachment has a hyperlinkURL then this is currently ignored
		DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
        imageView.shouldShowProgressiveDownload = YES;
		imageView.delegate = self;
		if (attachment.contents)
		{
			imageView.image = attachment.contents;
		}
		
		// url for deferred loading
		imageView.url = attachment.contentURL;
        
		return imageView;
	}
	
	return nil;
}


- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
	NSURL *url = lazyImageView.url;
	CGSize imageSize = size;
    
    CGFloat maxWidth = _textView.contentSize.width;
    if (imageSize.width > maxWidth)
    {
        double ratio = maxWidth / imageSize.width;
        imageSize.width = maxWidth;
        imageSize.height = imageSize.height * ratio;
    }
	
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
	
	// update all attachments that matchin this URL (possibly multiple images with same size)
	for (DTTextAttachment *oneAttachment in [_textView.attributedTextContentView.layoutFrame textAttachmentsWithPredicate:pred])
	{
		oneAttachment.originalSize = imageSize;
		
		if (!CGSizeEqualToSize(imageSize, oneAttachment.displaySize))
		{
			oneAttachment.displaySize = imageSize;
		}
	}
	
	// layout might have changed due to image sizes
	[_textView relayoutText];
}

- (void)renderEntry:(NSDictionary *)entry
{
    _titleLabel.text = entry[@"title"];
    
    NSString *htmlContent = entry[@"content"];
    htmlContent = [NSString stringWithFormat:@"<h1 style='font-weight: bold; font-size: 22px;'>%@</h1><hr><p>%@</p>", entry[@"title"], htmlContent];
    NSNumber *fontSize = nil;
    NSNumber *lineHeight = nil;
    if ([UIDevice currentDevice].isPad)
    {
        fontSize = @1.5;
        lineHeight = @1.4;
    }
    else
    {
        fontSize = @1.3;
        lineHeight = @1.3;
    }
    NSDictionary *options = @{
                              NSTextSizeMultiplierDocumentOption: fontSize,
                              DTDefaultLineHeightMultiplier: lineHeight,
                              DTDefaultFontFamily: @"黑体",
                              DTDefaultLinkDecoration: @"none"
                              };
    NSAttributedString *str = [[NSAttributedString alloc] initWithHTMLData:[htmlContent dataUsingEncoding:NSUTF8StringEncoding]
                                                                   options:options
                                                        documentAttributes:nil];
    _textView.attributedString = str;
}

@end
