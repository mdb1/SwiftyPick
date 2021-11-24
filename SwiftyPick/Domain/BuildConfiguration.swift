//
//  BuildConfiguration.swift
//  SwiftyPick
//
//  Created by Manu Herrera on 24/11/2021.
//

import Foundation

/// Returns if the current build is debug or release
var isDebug: Bool {
#if DEBUG
    return true
#else
    return false
#endif
}
