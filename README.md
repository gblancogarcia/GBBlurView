GBBlurView
==========

The GBBlurView class takes advantage of the new iOS 7 snapshot API to create a blur view. It is based on Apple sample code from “Implementing Engaging UI on iOS” WWDC 2013 session.

[![](https://dl.dropboxusercontent.com/u/5359105/GBBlurView/Menu-thumb.png)](https://dl.dropboxusercontent.com/u/5359105/GBBlurView/Menu.png)
[![](https://dl.dropboxusercontent.com/u/5359105/GBBlurView/Light-thumb.png)](https://dl.dropboxusercontent.com/u/5359105/GBBlurView/Light.png)
[![](https://dl.dropboxusercontent.com/u/5359105/GBBlurView/ExtraLight-thumb.png)](https://dl.dropboxusercontent.com/u/5359105/GBBlurView/ExtraLight.png)
[![](https://dl.dropboxusercontent.com/u/5359105/GBBlurView/Dark-thumb.png)](https://dl.dropboxusercontent.com/u/5359105/GBBlurView/Dark.png)
[![](https://dl.dropboxusercontent.com/u/5359105/GBBlurView/Tint-thumb.png)](https://dl.dropboxusercontent.com/u/5359105/GBBlurView/Tint.png)
[![](https://dl.dropboxusercontent.com/u/5359105/GBBlurView/Multitask-thumb.png)](https://dl.dropboxusercontent.com/u/5359105/GBBlurView/Multitask.png)

## Requirements

GBBlurView works on iOS 7 SDK or later and is compatible with ARC projects.

## Adding GBBlurView to your project

### Source files

You can directly add the source files to your project.

1. Download the [latest code version](https://github.com/gblancogarcia/GBBlurView/archive/master.zip). 
2. Open your project in Xcode, then drag and drop `GBBlurView.h` and `GBBlurView.m` onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project. 
3. Include GBBlurView wherever you need it with `#import "GBBlurView.h"`.

### Static library

You can also add GBBlurView as a static library to your project or workspace. 

1. Download the [latest code version](https://github.com/gblancogarcia/GBBlurView/archive/master.zip) or add the repository as a git submodule to your git-tracked project. 
2. Open your project in Xcode, then drag and drop `GBBlurView.xcodeproj` onto your project or workspace (use the "Product Navigator view"). 
3. Select your target and go to the Build phases tab. In the Link Binary With Libraries section select the add button. On the sheet find and add `libGBBlurView.a`. You might also need to add `GBBlurView` to the Target Dependencies list. 
4. Include GBBlurView wherever you need it with `#import <GBBlurView/GBBlurView.h>`.

## Usage

First, initialize the GBBlurView instance.
```objective-c
// Default initializer.
- (id)initWithFrame:(CGRect)frame;

// A convenience initializer that initializes the GBBlurView with the frame and the style.
- (id)initWithFrame:(CGRect)frame style:(GBBlurViewStyle)style;

// Designated initializer that initializes the GBBlurView with the frame, the style and the offset.
- (id)initWithFrame:(CGRect)frame style:(GBBlurViewStyle)style offset:(CGFloat)offset;

GBBlurView *blurView = [[GBBlurView alloc] initWithFrame:self.view.bounds style:GBBlurViewStyleImage];
```

Next, setup the GBBlurView instance:

```objective-c
blurView.title = @"Title";
blurView.subtitle = @"Subtitle";
blurView.image = [UIImage imageNamed:@"Image"];
blurView.blurEffect = GBBlurViewBlurEffectLight;
blurView.blurEffectMask = GBBlurViewBlurEffectDark;
blurView.masked = YES;
```

And finally, apply the blur effect:

```objective-c
[blurView applyBlurEffectFromView:self.view];
```
##License (MIT)

Copyright (c) 2013 Gerardo Blanco

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
