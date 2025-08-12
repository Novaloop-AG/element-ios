/*
Copyright 2024 New Vector Ltd.

SPDX-License-Identifier: AGPL-3.0-only
Please see LICENSE in the repository root for full details.
*/

#import <Foundation/Foundation.h>

/**
 OpenID token object for MSC1960 widget authentication
 */
@interface MXOpenIdToken : NSObject

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *tokenType;
@property (nonatomic, strong) NSString *matrixServerName;
@property (nonatomic) NSUInteger expiresIn;

@end