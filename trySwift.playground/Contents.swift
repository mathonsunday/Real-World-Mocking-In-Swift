//: Playground - noun: a place where people can play

import Cocoa

// Mocking Apple framework classes
// Could show MockUserDefaults and a test that uses it from the Pulse iOS app

// Common Test That Would Need a Mock To Not Cause Issues
// ex. network call using nsurlsession
// could copy from: http://masilotti.com/testing-nsurlsession-input
// use behavoir verification



// Class with several dependencies that we could easily identify and mock out
// What are some examples of common dependencies?
// 1) identify the dependencies we should mock
// 2) assume we have mocked versions of those dependencies
// 3) use DI to inject the dependencies


// Working with value types does mean you need to mock less
// Show an example of how using a reference type instead of a value type made it so we didn’t need to write a mock
// Why were you using that reference type in the first place? For ex. we copy pasted  NotificationCenterManager from Goups. the class in groups is an @objc class so i'm guessing it subclasses NSObject because of that.

// Where are we using value types in Oscar?
//Structs:
//Oscar/Business/VideoRecordingStorageManager.swift
// ErrorMessages in Oscar/Business/VideoCaptureManager.swift
// Notifications in Oscar/Business/VideoUploadManager.swift
// Oscar/DataAccess/TopicsService.swift, Oscar/DataAccess/VideosService.swift
// Oscar/Models/VideoRecording.swift
// Oscar/Networking/NetworkingHelper.swift
// Oscar/Networking/OscarApiClient.swift
// Oscar/Networking/SessionController.swift
// Oscar/UI/OnboardingViewHelper.swift
// Oscar/Utilities/Alert.swift
// Oscar/Utilities/BuildInfo.swift
// Oscar/Utilities/Constants.swift
// Key in Oscar/Utilities/UserDefaults.swift
// Enums:
// Method in Oscar/Networking/SessionController.swift
// Result in Oscar/Utilities/AsyncRequest.swift
// Error Domain in Oscar/Utilities/Extensions/NSError+.swift

// In Oscar: 35 non-mock, non-test classes
//           3 enums
//           17 top-level structs

func testNotificationSettingsLoad() {
    let mockUserDefaults = MockUserDefaults()
    mockUserDefaults.setObject("NEVER", forKey: "timeMachineBreakingNewsPushNotification")
    mockUserDefaults.setObject("NEVER", forKey: "timeMachineDailyDigestPushNotification")

    let dataProvider = PushNotificationsDataProvider(userDefaults: mockUserDefaults)
    let expectedFrequencies: [PushNotificationFrequency] = [.Never, .All, .All, .Never]

    XCTAssertEqual(expectedFrequencies, dataProvider.notificationSettings.values)

}


struct StubTimeMachineAPI: TimeMachineAPI {
    var videoUrl = "https://www.youtube.com/watch?v=SQ8aRKG9660"

    func getVideoFor(year: Int) -> String {
        return videoUrl
    }
}

struct Fake_MinionService: MinionGettable {
    var getTheMinionsWasCalled = false
    var fakeResult: MinionService.MinionDataResult?

    func getTheMinions(completionHandler: (MinionDataResult) -> Void) {
        getTheMinionsWasCalled = true
        completionHandler(fakeResult!)
    }
}

struct Fake_MinionService: MinionGettable {
    var getTheMinionsWasCalled = false
    var fakeResult: MinionService.MinionDataResult?

    func getTheMinions(completionHandler: (MinionDataResult) -> Void) {
        getTheMinionsWasCalled = true
        completionHandler(fakeResult!)
    }
}

extension TimeMachine {

}

struct MockTimeMachine: TimeMachine {
    var timeTravelWasCalled = false

    mutating func timeTravelTo(year: Int) {
        timeTravelWasCalled = true
    }
}

