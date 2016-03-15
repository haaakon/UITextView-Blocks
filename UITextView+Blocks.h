//
//  UITextView+Blocks.h
//  UITextViewBlocks
//
//  https://github.com/haaakon/
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
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import <UIKit/UIKit.h>

@interface UITextView (Blocks)

@property (copy, nonatomic) BOOL (^shouldBeginEditingBlock)(UITextView *textView);
@property (copy, nonatomic) BOOL (^shouldEndEditingBlock)(UITextView *textView);

@property (copy, nonatomic) void (^didBeginEditingBlock)(UITextView *textView);
@property (copy, nonatomic) void (^didEndEditingBlock)(UITextView *textView);

@property (copy, nonatomic) BOOL (^shouldChangeTextInRangeBlock)(UITextView *textView, NSRange range, NSString *replacementString);
@property (copy, nonatomic) void (^didChangeBlock)(UITextView *textView);

@property (copy, nonatomic) void (^didChangeSelectionBlock)(UITextView *textView);

@property (copy, nonatomic) BOOL (^shouldInteractWithURLBlock)(UITextView *textView, NSURL *URL, NSRange range) NS_AVAILABLE_IOS(7_0);
@property (copy, nonatomic) BOOL (^shouldInteractWithTextAttachmentBlock)(UITextView *textView, NSTextAttachment *textAttachment, NSRange range) NS_AVAILABLE_IOS(7_0);

- (void)setShouldBegindEditingBlock:(BOOL (^)(UITextView *textView))shouldBegindEditingBlock;
- (void)setShouldEndEditingBlock:(BOOL (^)(UITextView *textView))shouldEndEditingBlock;

- (void)setDidBeginEditingBlock:(void (^)(UITextView *textView))didBeginEditingBlock;
- (void)setDidEndEditingBlock:(void (^)(UITextView *textView))didEndEditingBlock;

- (void)setShouldChangeTextInRangeBlock:(BOOL (^)(UITextView *textView, NSRange range, NSString *string))shouldChangeTextInRangeBlock;
- (void)setDidChangeBlock:(void (^)(UITextView *textView))didChangeBlock;

- (void)setDidChangeSelectionBlock:(void (^)(UITextView *textView))didChangeSelectionBlock;

- (void)setShouldInteractWithURLBlock:(BOOL (^)(UITextView *textView, NSURL *URL, NSRange range))shouldInteractWithURLBlock NS_AVAILABLE_IOS(7_0);
- (void)setShouldInteractWithTextAttachmentBlock:(BOOL (^)(UITextView *textView, NSTextAttachment *textAttachment, NSRange range))shouldInteractWithTextAttachmentBlock NS_AVAILABLE_IOS(7_0);

@end
