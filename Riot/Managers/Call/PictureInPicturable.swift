// 
// Copyright 2024 New Vector Ltd
//
// SPDX-License-Identifier: AGPL-3.0-only
// Please see LICENSE in the repository root for full details.
//

import Foundation

@objc protocol PictureInPicturable {
    
    @objc optional func willEnterPiP()
    @objc optional func didEnterPiP()
    
    @objc optional func willExitPiP()
    @objc optional func didExitPiP()
    
}
