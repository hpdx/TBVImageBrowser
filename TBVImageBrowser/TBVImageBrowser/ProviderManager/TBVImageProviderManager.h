//
//  TBVImageProviderManager.h
//  TBVImageBrowser
//
//  Created by tripleCC on 9/13/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBVImageProviderManagerProtocol.h"

CF_EXPORT NSString *const kTBVImageProviderManagerNotFoundKey;
@interface TBVImageProviderManager : NSObject <TBVImageProviderManagerProtocol>

@end
