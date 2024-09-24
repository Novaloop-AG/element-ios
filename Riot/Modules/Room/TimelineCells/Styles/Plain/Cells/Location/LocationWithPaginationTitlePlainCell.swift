// 
// Copyright 2024 New Vector Ltd
//
// SPDX-License-Identifier: AGPL-3.0-only
// Please see LICENSE in the repository root for full details.
//

import Foundation

class LocationWithPaginationTitlePlainCell: LocationPlainCell {
    override func setupViews() {
        super.setupViews()
        
        roomCellContentView?.showPaginationTitle = true
    }
}
