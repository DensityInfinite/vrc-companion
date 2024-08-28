# VRC Companion

A WIP, extremely agile competition assistant application for the VEX Robotics Competition, set to release in 2025 on iOS.

It is also the submission for Assessment Task 3 (2024 Major Work).

## For Competitors and Coaches

No public builds are available at the moment.

Expect closed beta testing to start by the end of the year through [TestFlight](https://testflight.apple.com).

## For Developers (and Markers)

Contributions are welcome. Please note that this codebase was initially written as a Year 12 Major Work project - expect some janky code and bad practices. Open a PR if you find some. **For markers, be rest assured that no one apart from the student himself has contributed to this codebase prior to submission.** You can verify this in the commit history.

If you are to fork the repository, please follow the licence agreement.

### Building From Source

Xcode is required to build/modify *VRC Companion*.

> [!NOTE]
> Only Xcode 15 is officially supported. Xcode 16 has not been tested.

1. Download Xcode from the App Store. Install all required toolchains if prompted.
2. Follow [Apple's guide to authenticate your GitHub account in Xcode](https://developer.apple.com/documentation/xcode/configuring-your-xcode-project-to-use-source-control#Get-a-project-from-a-remote-repository).
3. At the start menu, select "Clone Git Repository...".
4. Clone this repository using the URL.
5. Obtain and put your [RobotEvents API key](https://www.robotevents.com/api/v2/) in ./VRC Companion/Models/NetworkRequests.swift, line 18. **If you are an assessment marker, you do not need to request a key - an API key has already been given to you as part of the submitted documents.** I acknowledge that this is very unsafe, and a better method is in the works. For now, please take caution to never commit your API key onto the repository.

Initiate a build for running using `⌘B`.

### Testing a Full Build (and Marking)

It is recommended to test a full build on an iOS device. Alternatively, you can choose to run the project in a simulator.

To initiate a run, simply select your preferred device/simulator in the toolbar and press `⌘R`.

If you have never done this before, please follow [Apple's guide on setting up your simulator and iOS device](https://developer.apple.com/documentation/xcode/running-your-app-in-simulator-or-on-a-device). It should take no more than 15 minutes.

## Credits

*VRC Companion* was originally developed (with ♥︎) by DensityInfinite, member of the 1051X Siege V5RC team.

The following projects/people have greatly impacted development. Without them, this project would not have existed.

A big thank-you to:

- [VRC RoboScout](https://github.com/SunkenSplash/VRC-RoboScout) by SunkenSplash, for the sparking of this idea.
- [Matteo Manferdini](https://matteomanferdini.com), for tutorials, critical architectural insights, preview extensions, and the networking layer.
- [Hacking with Swift](https://www.hackingwithswift.com), for tutorials on key concepts.
