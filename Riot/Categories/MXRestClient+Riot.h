/*
Copyright 2024 New Vector Ltd.

SPDX-License-Identifier: AGPL-3.0-only
Please see LICENSE in the repository root for full details.
*/

#import <MatrixSDK/MatrixSDK.h>
#import "MXOpenIdToken.h"

@interface MXRestClient (Riot)

/**
 Request an OpenID token for widget authentication (MSC1960)
 
 @param success A block object called when the operation succeeds. It provides the OpenID token.
 @param failure A block object called when the operation fails.
 
 @return a MXHTTPOperation instance.
 */
- (MXHTTPOperation*)openIdToken:(void (^)(MXOpenIdToken *token))success
                         failure:(void (^)(NSError *error))failure;

@end