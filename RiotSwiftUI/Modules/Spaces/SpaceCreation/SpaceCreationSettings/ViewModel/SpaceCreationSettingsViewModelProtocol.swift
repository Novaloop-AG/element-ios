// File created from TemplateAdvancedRoomsExample
// $ createSwiftUITwoScreen.sh Spaces/SpaceCreation SpaceCreation SpaceCreationMenu SpaceCreationSettings
//
// Copyright 2024 New Vector Ltd
//
// SPDX-License-Identifier: AGPL-3.0-only
// Please see LICENSE in the repository root for full details.
//

import Foundation
import UIKit

protocol SpaceCreationSettingsViewModelProtocol {
    var callback: ((SpaceCreationSettingsViewModelAction) -> Void)? { get set }
    func updateAvatarImage(with image: UIImage?)
}
