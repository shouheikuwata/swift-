//
//  Swift_App_Dev_SpeUnitUITestsLaunchTests.swift
//  Swift_App_Dev_SpeUnitUITests
//
//  Created by 桑田翔平 on 2022/06/29.
//

import XCTest

class Swift_App_Dev_SpeUnitUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
