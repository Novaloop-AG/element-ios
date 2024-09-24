//
// Copyright 2017-2024 New Vector Ltd
//
// SPDX-License-Identifier: AGPL-3.0-only
// Please see LICENSE in the repository root for full details.
//

import Foundation

class MatrixItemChooserRoomsDataSource: MatrixItemChooserDataSource {
    var preselectedItemIds: Set<String>? { nil }

    func sections(with session: MXSession, completion: @escaping (Result<[MatrixListItemSectionData], Error>) -> Void) {
        completion(Result(catching: {
            [
                MatrixListItemSectionData(items: session.rooms.compactMap { room in
                    if room.summary.roomType == .space || room.isDirect {
                        return nil
                    }
                    
                    return MatrixListItemData(mxRoom: room, spaceService: session.spaceService)
                })
            ]
        }))
    }
}
