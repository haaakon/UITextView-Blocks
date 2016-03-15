UITextView-Blocks
==================

Adds blocks to all UITextView delegate methods with a category, no subclassing. Also allows the use of delegate methods if no block is set.

Installation
============
Simply use [CocoaPods](http://cocoapods.org/):

`pod 'UITextView+Blocks'`

USAGE
=====

#### textViewShouldBeginEditing
```objective-c

#import <UITextView+Blocks.h>
UITextView *aTextField;
[aTextView setShouldBegindEditingBlock:^BOOL(UITextView *textField) {
        // do your stuff here
        return YES;
}];
    
```

#### textViewDidBeginEditing

```objective-c
[aTextView setDidBeginEditingBlock:^(UITextView *textField) {
        // do your stuff here
}];
    
```

#### textViewShouldEndEditing

```objective-c
[aTextView setShouldEndEditingBlock:^BOOL(UITextView *textField) {
        // do your stuff here
        return YES;
  }];
    
```

#### textViewDidEndEditing

```objective-c
[aTextView setDidEndEditingBlock:^BOOL(UITextView *textField) {
        // do your stuff here
  }];
    
```

#### textView:shouldChangeTextInRange:replacementString:

```objective-c
[aTextView setShouldChangeTextInRangeBlock:^BOOL(UITextView *textField, NSRange range, NSString *replacementString) {
        // do your stuff here
        return YES;
}];
    
```

#### textViewDidChange

```objective-c
[aTextView setDidChangeBlock:^(UITextView *textField) {
        // do your stuff here
}];
    
```

#### textViewDidChangeSelectionBlock

```objective-c
[aTextView setDidChangeSelectionBlock:^(UITextView *textField) {
        // do your stuff here
}];
    
```

#### textView:shouldInteractWithURL:inRange:

```objective-c
[aTextView setShouldInteractWithURLBlock:^BOOL(UITextView *textField, NSURL *URL, NSRange range) {
        // do your stuff here
        return YES;
}];
    
```
#### textView:shouldInteractWithTextAttachment:inRange:

```objective-c
[aTextView setShouldInteractWithTextAttachmentBlock:^BOOL(UITextView *textField, NSTextAttachment *textAttachment, NSRange range) {
        // do your stuff here
        return YES;
}];
    
```

Remember, you can also use ordinary delegate methods for all methods you don't define as blocks.

In this example, shouldBeginEditing is defined as a block, and didEndEditing is a delegate method

```objective-c

aTextView.delegate = self;

[aTextView setShouldBeginEditingBlock:^BOOL(UITextView *textView) {
        // do your stuff here
        return YES;
    }];

- (void)textViewDidEndEditing:(UITextView *)textView
{
    // do your stuff here
}
```   

### LICENSE

Copyright (C) 2013 Developed by Håkon Bogen

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE
