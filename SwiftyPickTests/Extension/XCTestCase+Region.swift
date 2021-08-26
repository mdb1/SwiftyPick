//
//  XCTestCase+Region.swift
//  SwiftyPickTests
//
//  Created by Manu Herrera on 26/08/2021.
//

import XCTest

enum CountryISOCode {
    /// iso2 code for Argentina
    static let argentina = "AR"
    /// iso2 code for the United States
    static let unitedStates = "US"
}

extension XCTestCase {
    /// Way around getting the current configuration for the unit tests
    enum TestingRegion {
        case argentina
        case unitedStates // default

        static var current: TestingRegion {
            switch Locale.current.regionCode {
            case CountryISOCode.argentina:
                return .argentina
            case CountryISOCode.unitedStates:
                return .unitedStates
            default:
                return .unitedStates
            }
        }
    }
}
