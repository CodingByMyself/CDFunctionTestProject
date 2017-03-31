//
//  CDTestFaceInputViewController.m
//  CDFunctionTestProject
//
//  Created by Cindy on 2017/3/9.
//  Copyright © 2017年 Cindy. All rights reserved.
//

#import "CDTestFaceInputViewController.h"
#import "CDFaceView.h"
#import "EmojiTextAttachment.h"

@interface CDTestFaceInputViewController () <CDFaceViewDelegate,UITextViewDelegate>
@property (nonatomic,strong) UITextView *textViewInput;
@property (nonatomic,strong) CDFaceView *faceView;
@end

@implementation CDTestFaceInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"表情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.faceView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.faceView setTheFaceViewDelegate:self];
    
    self.textViewInput.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.faceView reloadFaceView];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark
- (void)textViewDidChange:(UITextView *)textView
{
    [UIView animateWithDuration:0.15 animations:^{
//        [textView setContentOffset:CGPointMake(0, textView.contentSize.height-textView.bounds.size.height)];
    }];
}

#pragma mark - Delegate method
- (void)didSelectedEmojString:(NSString *)string
{
    //Create emoji attachment
    EmojiTextAttachment *emojiTextAttachment = [EmojiTextAttachment new];
    
    //Set tag and image
    emojiTextAttachment.emojiTag = string;
    emojiTextAttachment.image = [UIImage imageNamed:string];
    
    //Set emoji size
    emojiTextAttachment.emojiSize = 20;
    
    //Insert emoji image
    [self.textViewInput.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:emojiTextAttachment]
                                                   atIndex:self.textViewInput.selectedRange.location];
    
    //Move selection location
    self.textViewInput.selectedRange = NSMakeRange(self.textViewInput.selectedRange.location + 1, self.textViewInput.selectedRange.length);
    
    [self textViewDidChange:self.textViewInput];
    
}

- (void)didClickedDeleteButton
{
    [self.textViewInput deleteBackward];
}

#pragma mark - Getter Method
- (UITextView *)textViewInput
{
    if (_textViewInput == nil) {
        _textViewInput = [[UITextView alloc] init];
        _textViewInput.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _textViewInput.layer.cornerRadius = 6.0;
        _textViewInput.textColor = [UIColor blackColor];
        _textViewInput.font = [UIFont systemFontOfSize:15.0];
        [self.view addSubview:_textViewInput];
        [_textViewInput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(10);
            make.right.equalTo(self.view).offset(-10);
            make.top.equalTo(self.view).offset(80.0);
            make.height.equalTo(@80.0);
        }];
    }
    return _textViewInput;
}

- (CDFaceView *)faceView
{
    if (_faceView == nil) {
        _faceView = [[CDFaceView alloc] init];
        [self.view addSubview:_faceView];
        [_faceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-10.0);
            make.height.equalTo(@200.0);
        }];
    }
    return _faceView;
}

@end
