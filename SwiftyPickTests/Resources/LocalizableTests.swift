//
//  LocalizableTests.swift
//  SwiftyPickTests
//
//  Created by Manu Herrera on 26/08/2021.
//

@testable import SwiftyPick
import XCTest

class LocalizableTests: XCTestCase {
    // This shallow test is just to ensure that we didn't break the translation mechanism.
    func testGreetingTranslation() {
        let greetingHello = L10n.Greeting.hello
        let greetingWorld = L10n.Greeting.world

        switch TestingRegion.current {
        case .argentina:
            // Uses spanish translation
            XCTAssertEqual(greetingHello, "Hola")
            XCTAssertEqual(greetingWorld, "mundo")
            XCTAssertEqual(L10n.Greeting.person("Manu"), "Hola Manu")
        case .unitedStates:
            XCTAssertEqual(greetingHello, "Hello")
            XCTAssertEqual(greetingWorld, "world")
            XCTAssertEqual(L10n.Greeting.person("Manu"), "Hello Manu")
        }
    }

    func testFeaturesScreenTexts() {
        let title = L10n.FeaturesScreen.title
        let uiSectionTitle = L10n.FeaturesScreen.Sections.UserInterface.title

        switch TestingRegion.current {
        case .argentina:
            XCTAssertEqual(title, "Funcionalidades")
            XCTAssertEqual(uiSectionTitle, "Interfaz de Usuario")
        case .unitedStates:
            XCTAssertEqual(title, "Features")
            XCTAssertEqual(uiSectionTitle, "User Interface")
        }
    }

    func testColorPaletteScreenTexts() {
        let title = L10n.ColorPaletteScreen.title

        switch TestingRegion.current {
        case .argentina:
            XCTAssertEqual(title, "Paletas de Colores")
        case .unitedStates:
            XCTAssertEqual(title, "Color Palettes")
        }
    }

    // Future improvement: Write a script that:
    // 1. Fetches the strings from the localizable files
    // 2. Asserts that all the localization strings matches their region

}
