//
//  UITextView+Blocks.m
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

#import "UITextView+Blocks.h"
#import <objc/runtime.h>

typedef BOOL (^UITextViewReturnBlock) (UITextView *textView);
typedef void (^UITextViewVoidBlock) (UITextView *textView);
typedef BOOL (^UITextViewTextChangeBlock) (UITextView *textView, NSRange range, NSString *replacementString);
typedef BOOL (^UITextViewInteractWithURLBlock) (UITextView *textView, NSURL *URL, NSRange range);
typedef BOOL (^UITextViewInteractWithTextAttachmentBlock) (UITextView *textView, NSTextAttachment *textAttachment, NSRange range);

@implementation UITextView (Blocks)

static const void *UITextViewDelegateKey                           = &UITextViewDelegateKey;

static const void *UITextViewShouldBeginEditingKey                 = &UITextViewShouldBeginEditingKey;
static const void *UITextViewShouldEndEditingKey                   = &UITextViewShouldEndEditingKey;

static const void *UITextViewDidBeginEditingKey                    = &UITextViewDidBeginEditingKey;
static const void *UITextViewDidEndEditingKey                      = &UITextViewDidEndEditingKey;

static const void *UITextViewShouldChangeTextInRangeKey			   = &UITextViewShouldChangeTextInRangeKey;
static const void *UITextViewDidChangeKey                          = &UITextViewDidChangeKey;

static const void *UITextViewDidChangeSelectionKey                 = &UITextViewDidChangeSelectionKey;

static const void *UITextViewShouldInteractWithURLKey			   = &UITextViewShouldInteractWithURLKey;
static const void *UITextViewShouldInteractWithTextAttachmentKey   = &UITextViewShouldInteractWithTextAttachmentKey;

#pragma mark UITextView Delegate methods

+ (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    UITextViewReturnBlock block = textView.shouldBeginEditingBlock;
    if (block) {
        return block(textView);
    }
    
    id delegate = objc_getAssociatedObject(self, UITextViewDelegateKey);
    
    if ([delegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
       return [delegate textViewShouldBeginEditing:textView];
    }
    // return default value just in case
    return YES;
}

+ (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    UITextViewReturnBlock block = textView.shouldEndEditingBlock;
    if (block) {
        return block(textView);
    }
    
    id delegate = objc_getAssociatedObject(self, UITextViewDelegateKey);
    
    if ([delegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [delegate textViewShouldEndEditing:textView];
    }
    // return default value just in case
    return YES;
}

+ (void)textViewDidBeginEditing:(UITextView *)textView
{
    UITextViewVoidBlock block = textView.didBeginEditingBlock;
    if (block) {
        block(textView);
    }
    
    id delegate = objc_getAssociatedObject(self, UITextViewDelegateKey);
    
    if ([delegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [delegate textViewDidBeginEditing:textView];
    }
}

+ (void)textViewDidEndEditing:(UITextView *)textView
{
    UITextViewVoidBlock block = textView.didEndEditingBlock;
    if (block) {
        block(textView);
    }
    
    id delegate = objc_getAssociatedObject(self, UITextViewDelegateKey);
    
    if ([delegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [delegate textViewDidBeginEditing:textView];
    }
}

+ (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextViewTextChangeBlock block = textView.shouldChangeTextInRangeBlock;
    if (block) {
        return block(textView,range,string);
    }
    
    id delegate = objc_getAssociatedObject(self, UITextViewDelegateKey);
    
    if ([delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementString:)]) {
        return [delegate textView:textView shouldChangeTextInRange:range replacementString:string];
    }
    return YES;
}

+ (void)textViewDidChange:(UITextView *)textView
{
	UITextViewVoidBlock block = textView.didChangeBlock;
	if (block) {
		block(textView);
	}
	
	id delegate = objc_getAssociatedObject(self, UITextViewDelegateKey);
	
	if ([delegate respondsToSelector:@selector(textViewDidChange:)]) {
		[delegate textViewDidChange:textView];
	}
}

+ (void)textViewDidChangeSelection:(UITextView *)textView
{
	UITextViewVoidBlock block = textView.didChangeSelectionBlock;
	if (block) {
		block(textView);
	}
	
	id delegate = objc_getAssociatedObject(self, UITextViewDelegateKey);
	
	if ([delegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
		[delegate textViewDidChangeSelection:textView];
	}
}

+ (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL*)URL inRange:(NSRange)range
{
	UITextViewInteractWithURLBlock block = textView.shouldInteractWithURLBlock;
	if (block) {
		return block(textView,URL,range);
	}
	
	id delegate = objc_getAssociatedObject(self, UITextViewDelegateKey);
	
	if ([delegate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)]) {
		return [delegate textView:textView shouldInteractWithURL:URL inRange:range];
	}
	return YES;
}

+ (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)range
{
	UITextViewInteractWithTextAttachmentBlock block = textView.shouldInteractWithTextAttachmentBlock;
	if (block) {
		return block(textView,textAttachment,range);
	}
	
	id delegate = objc_getAssociatedObject(self, UITextViewDelegateKey);
	
	if ([delegate respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)]) {
		return [delegate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:range];
	}
	return YES;
}

#pragma mark Block setting/getting methods

- (BOOL (^)(UITextView *))shouldBeginEditingBlock
{
    return objc_getAssociatedObject(self, UITextViewShouldBeginEditingKey);
}

- (void)setShouldBeginEditingBlock:(BOOL (^)(UITextView *))shouldBeginEditingBlock
{
    [self setDelegateIfNoDelegateSet];
     objc_setAssociatedObject(self, UITextViewShouldBeginEditingKey, shouldBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UITextView *))shouldEndEditingBlock
{
    return objc_getAssociatedObject(self, UITextViewShouldEndEditingKey);
}

- (void)setShouldEndEditingBlock:(BOOL (^)(UITextView *))shouldEndEditingBlock
{
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextViewShouldEndEditingKey, shouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UITextView *))didBeginEditingBlock
{
    return objc_getAssociatedObject(self, UITextViewDidBeginEditingKey);
    
}

- (void)setDidBeginEditingBlock:(void (^)(UITextView *))didBeginEditingBlock
{
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextViewDidBeginEditingKey, didBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UITextView *))didEndEditingBlock
{
    return objc_getAssociatedObject(self, UITextViewDidEndEditingKey);
}

- (void)setDidEndEditingBlock:(void (^)(UITextView *))didEndEditingBlock
{
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextViewDidEndEditingKey, didEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UITextView *, NSRange, NSString *))shouldChangeTextInRangeBlock
{
    return objc_getAssociatedObject(self, UITextViewShouldChangeTextInRangeKey);
}

- (void)setShouldChangeTextInRangeBlock:(BOOL (^)(UITextView *, NSRange, NSString *))shouldChangeTextInRangeBlock
{
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextViewShouldChangeTextInRangeKey, shouldChangeTextInRangeBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UITextView *))didChangeBlock
{
	return objc_getAssociatedObject(self, UITextViewDidChangeKey);
	
}

- (void)setDidChangeBlock:(void (^)(UITextView *))didChangeBlock
{
	[self setDelegateIfNoDelegateSet];
	objc_setAssociatedObject(self, UITextViewDidChangeKey, didChangeBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UITextView *))didChangeSelectionBlock
{
	return objc_getAssociatedObject(self, UITextViewDidChangeSelectionKey);
	
}

- (void)setDidChangeSelectionBlock:(void (^)(UITextView *))didChangeSelectionBlock
{
	[self setDelegateIfNoDelegateSet];
	objc_setAssociatedObject(self, UITextViewDidChangeSelectionKey, didChangeSelectionBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UITextView *, NSURL* , NSRange))shouldInteractWithURLBlock
{
	return objc_getAssociatedObject(self, UITextViewShouldInteractWithURLKey);
}

- (void)setShouldInteractWithURLBlock:(BOOL (^)(UITextView *, NSURL* , NSRange))shouldInteractWithURLBlock
{
	[self setDelegateIfNoDelegateSet];
	objc_setAssociatedObject(self, UITextViewShouldInteractWithURLKey, shouldInteractWithURLBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UITextView *, NSURL* , NSRange))shouldInteractWithTextAttachmentBlock
{
	return objc_getAssociatedObject(self, UITextViewShouldInteractWithTextAttachmentKey);
}

- (void)setShouldInteractWithTextAttachmentBlock:(BOOL (^)(UITextView *, NSURL* , NSRange))shouldInteractWithTextAttachmentBlock
{
	[self setDelegateIfNoDelegateSet];
	objc_setAssociatedObject(self, UITextViewShouldInteractWithTextAttachmentKey, shouldInteractWithTextAttachmentBlock, OBJC_ASSOCIATION_COPY);
}

#pragma mark control method
/*
 Setting itself as delegate if no other delegate has been set. This ensures the UITextView will use blocks if no delegate is set.
 */
- (void)setDelegateIfNoDelegateSet
{
    if (self.delegate != (id<UITextViewDelegate>)[self class]) {
        objc_setAssociatedObject(self, UITextViewDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UITextViewDelegate>)[self class];
    }
}

@end
