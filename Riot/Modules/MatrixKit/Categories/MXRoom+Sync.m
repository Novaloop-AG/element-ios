/*
 Copyright 2017-2024 New Vector Ltd

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "MXRoom+Sync.h"

@implementation MXRoom (Sync)

- (MXRoomState *)dangerousSyncState
{
    __block MXRoomState *syncState;

    // If syncState is called from the right place, the following call will be
    // synchronous and every thing will be fine
    [self state:^(MXRoomState *roomState) {
        syncState = roomState;
    }];

    NSAssert(syncState, @"[MXRoom+Sync] syncState failed. Are you sure the state of the room has been already loaded?");

    return syncState;
}

@end
