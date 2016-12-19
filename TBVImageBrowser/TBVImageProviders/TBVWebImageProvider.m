//
//  TBVWebImageProvider.m
//  TBVImageBrowser
//
//  Created by tripleCC on 9/13/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//
#import <SDWebImage/SDWebImageManager.h>
#import "TBVWebImageProvider.h"
#import "NSError+TBVImageProvider.h"

NSString *const kTBVWebImageProviderIdentifier = @"kTBVWebImageProviderIdentifier";

@interface TBVWebImageProvider()
@property (strong, nonatomic) SDWebImageManager *downloadManager;
@end

@implementation TBVWebImageProvider
- (NSString *)identifier {
    return kTBVWebImageProviderIdentifier;
}

- (RACSignal *)imageSignalForElement:(id<TBVImageElementProtocol>)element progress:(TBVImageProviderProgressBlock)progress {
    @weakify(self)
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        id <SDWebImageOperation> operation = nil;
        if ([element.resource isKindOfClass:[NSURL class]] &&
            [[[(NSURL *)element.resource scheme] lowercaseString] containsString:@"http"]) {
            operation = [self.downloadManager downloadImageWithURL:(NSURL *)element.resource
                                                           options:SDWebImageRetryFailed
                                                          progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                              progress(receivedSize / (CGFloat)expectedSize);
                                                          }
                                                         completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if (error) {
                    [subscriber sendError:error];
                } else {
                    progress(1);
                    [subscriber sendNext:image];
                    [subscriber sendCompleted];
                }
            }];
        } else {
            NSString *message = [NSString stringWithFormat:@"the resource of elememt(%@) is not a web url.", element.resource];
            [subscriber sendError:[NSError errorWithDomain:@"TBVWebImageProvider" message:message]];
        }
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }] deliverOnMainThread];
}

- (SDWebImageManager *)downloadManager {
    if (_downloadManager == nil) {
        _downloadManager = [SDWebImageManager sharedManager];
    }
    
    return _downloadManager;
}
@end
