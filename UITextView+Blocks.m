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
typedef BOOL (^UITextViewCharacterChangeBlock) (UITextView *textView, NSRange range, NSString *replacementString);

@implementation UITextView (Blocks)

static const void *UITextViewDelegateKey                           = &UITextViewDelegateKey;

static const void *UITextViewShouldBeginEditingKey                 = &UITextViewShouldBeginEditingKey;
static const void *UITextViewShouldEndEditingKey                   = &UITextViewShouldEndEditingKey;

static const void *UITextViewDidBeginEditingKey                    = &UITextViewDidBeginEditingKey;
static const void *UITextViewDidEndEditingKey                      = &UITextViewDidEndEditingKey;

static const void *UITextViewShouldChangeCharactersInRangeKey      = &UITextViewShouldChangeCharactersInRangeKey;

static const void *UITextViewShouldClearKey                        = &UITextViewShouldClearKey;
static const void *UITextViewShouldReturnKey                       = &UITextViewShouldReturnKey;

#pragma mark UITextView Delegate methods

+ (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    UITextViewReturnBlock block = textView.shouldBegindEditingBlock;
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

+ (BOOL)textView:(UITextView *)textView shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextViewCharacterChangeBlock block = textView.shouldChangeCharactersInRangeBlock;
    if (block) {
        return block(textView,range,string);
    }
    
    id delegate = objc_getAssociatedObject(self, UITextViewDelegateKey);
    
    if ([delegate respondsToSelector:@selector(textView:shouldChangeCharactersInRange:replacementString:)]) {
        return [delegate textView:textView shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

+ (BOOL)textViewShouldClear:(UITextView *)textView
{
    UITextViewReturnBlock block = textView.shouldClearBlock;
    if (block) {
        return block(textView);
    }
    
    id delegate = objc_getAssociatedObject(self, UITextViewDelegateKey);
    
    if ([delegate respondsToSelector:@selector(textViewShouldClear:)]) {
        return [delegate textViewShouldClear:textView];
    }
    return YES;
}

+ (BOOL)textViewShouldReturn:(UITextView *)textView
{
    UITextViewReturnBlock block = textView.shouldReturnBlock;
    if (block) {
        return block(textView);
    }
    
    id delegate = objc_getAssociatedObject(self, UITextViewDelegateKey);
    
    if ([delegate respondsToSelector:@selector(textViewShouldReturn:)]) {
        return [delegate textViewShouldReturn:textView];
    }
    return YES;
}

#pragma mark Block setting/getting methods

- (BOOL (^)(UITextView *))shouldBegindEditingBlock
{
    return objc_getAssociatedObject(self, UITextViewShouldBeginEditingKey);
}

- (void)setShouldBegindEditingBlock:(BOOL (^)(UITextView *))shouldBegindEditingBlock
{
    [self setDelegateIfNoDelegateSet];
     objc_setAssociatedObject(self, UITextViewShouldBeginEditingKey, shouldBegindEditingBlock, OBJC_ASSOCIATION_COPY);
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

- (BOOL (^)(UITextView *, NSRange, NSString *))shouldChangeCharactersInRangeBlock
{
    return objc_getAssociatedObject(self, UITextViewShouldChangeCharactersInRangeKey);
}

- (void)setShouldChangeCharactersInRangeBlock:(BOOL (^)(UITextView *, NSRange, NSString *))shouldChangeCharactersInRangeBlock
{
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextViewShouldChangeCharactersInRangeKey, shouldChangeCharactersInRangeBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UITextView *))shouldReturnBlock
{
    return objc_getAssociatedObject(self, UITextViewShouldReturnKey);
}

- (void)setShouldReturnBlock:(BOOL (^)(UITextView *))shouldReturnBlock
{
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextViewShouldReturnKey, shouldReturnBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UITextView *))shouldClearBlock
{
    return objc_getAssociatedObject(self, UITextViewShouldClearKey);
}

- (void)setShouldClearBlock:(BOOL (^)(UITextView *textView))shouldClearBlock
{
    [self setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextViewShouldClearKey, shouldClearBlock, OBJC_ASSOCIATION_COPY);
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
