//
//  TBVImageProviderProtocol.h
//  TBVImageBrowser
//
//  Created by tripleCC on 9/13/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#ifndef TBVImageProviderProtocol_h
#define TBVImageProviderProtocol_h
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "TBVImageElementProtocol.h"
#import "TBVImageProviderIdentifierProtocol.h"

typedef void (^TBVImageProviderProgressBlock) (CGFloat);
@protocol TBVImageProviderProtocol <TBVImageProviderIdentifierProtocol>
@required
- (RACSignal *)imageSignalForElement:(id <TBVImageElementProtocol>)element
                            progress:(TBVImageProviderProgressBlock)progress;
@end

#endif /* TBVImageProviderProtocol_h */
