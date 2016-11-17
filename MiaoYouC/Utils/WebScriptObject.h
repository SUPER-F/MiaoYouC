//
//  WebScriptObject.h
//  MiaoYouC
//
//  Created by drupem on 16/11/16.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebScriptObject : NSObject

@end

@interface WebView
- (WebScriptObject *)windowScriptObject;
@end

@interface UIWebDocumentView: UIView
- (WebView *)webView;
@end
