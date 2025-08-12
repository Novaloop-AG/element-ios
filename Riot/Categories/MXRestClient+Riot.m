/*
Copyright 2024 New Vector Ltd.

SPDX-License-Identifier: AGPL-3.0-only
Please see LICENSE in the repository root for full details.
*/

#import "MXRestClient+Riot.h"

@implementation MXRestClient (Riot)

- (MXHTTPOperation*)openIdToken:(void (^)(MXOpenIdToken *token))success
                         failure:(void (^)(NSError *error))failure
{
    NSString *path = [NSString stringWithFormat:@"%@/user/%@/openid/request_token",
                      kMXAPIPrefixPathR0, self.credentials.userId];
    
    MXWeakify(self);
    return [self requestWithMethod:@"POST"
                              path:path
                        parameters:@{}
                           success:^(NSDictionary *JSONResponse) {
        MXStrongifyAndReturnIfNil(self);
        
        MXOpenIdToken *token = [[MXOpenIdToken alloc] init];
        token.accessToken = JSONResponse[@"access_token"];
        token.tokenType = JSONResponse[@"token_type"] ?: @"Bearer";
        token.matrixServerName = JSONResponse[@"matrix_server_name"] ?: self.homeserver;
        token.expiresIn = [JSONResponse[@"expires_in"] unsignedIntegerValue];
        
        if (success)
        {
            success(token);
        }
    } failure:failure];
}

@end