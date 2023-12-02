
# RunWeather - iOS Capstone 

The main purpose of this app is to meet the requirements of my [Kodeco Bootcamp Capstone](https://www.kodeco.com/home). 

# Introduction
RunWeather is your essential iOS weather guide for runners, designed to help you find the ideal time to hit the pavement. Effortlessly check hourly forecasts, customize preferences for temperature and rain, and get clear visuals of upcoming weather conditions. Quick setup with ZIP code entry and intuitive controls means less time planning and more time running. RunWeather is all about making sure you have sunshine on your path and the wind at your back.

## Technology Stack

RunWeather is built entirely using Apple’s latest programming language Swift, known for its performance and safety features. We leverage the power of SwiftUI, Apple’s modern UI toolkit, to create a seamless and responsive user interface that provides a native experience on iOS devices. This combination allows for a robust app architecture and efficient performance, ensuring a smooth and reliable user experience.

Programming Language: Swift
UI Toolkit: SwiftUI
Networking: URLSession for API calls
Data Persistence: UserDefaults, Files, and Keychain
Concurrency: Swift Modern Concurrency with async/await
Architecture: MVVM (Model-View-ViewModel)
The app stands out by not relying on any third-party libraries, showcasing the capabilities of Swift and SwiftUI to handle complex tasks natively.

## Dependencies

To successfully run the application on your machine, you need to sign up for a free account as an AccuWeather Developer and get the API key. Create a new plist file called `ACCUWEATHER-info.plist` with 1 key and assign that value to `ACCUWEATHER_API_KEY`.


For more information and to obtain your free tier API key, visit the [AccuWeather APIs](https://developer.accuweather.com/apis).


## Requirements
Graded pass/fail. 

- [x]  We suggest using Xcode 14.3 or 14.3.1 and iOS 16.x, rather than Xcode 15 and iOS 17. You can use the latest versions if you like, but remember that the videos and other content you’re learning from may not reflect the newer versions.
- [x]  The app has a README file, including a basic explanation of the app and explanations of how your app fulfills each rubric item. Identify your features and any specific file names so your mentor doesn’t have to search for them while grading.
- [x]  The app does not use any third-party frameworks.
- [x]  The app has a launch screen suitable for the app. It can be either a static or animated launch screen.
- [x]  All features in the app should be completed. Any unfinished feature should be moved to a different branch.
- [x]  The app has at least one screen with a list using a view of your choice (List, Grid, ScrollView etc). This list should appear in a tab view with at least two tabs. 
- [x]  Each item in the list should contain (at minimum) a name, a subtitle or description, and an image of the item, and any text should be styled appropriately. Tapping an item in this list should navigate (NavigationStack)  to a detail view: This should show the same data in the list item with some further details such as a longer description, bigger picture, price, or a Buy/Order button. Include enough items to ensure that the user has to scroll the list to see all the items in it.
- [x]  The app has one or more network calls using URLSession to download/upload data related to the core tasks of the app. The app’s repo does not contain API keys or other authentication information. Don’t store API keys or other authentication information in your app’s repo. 
- [x]  If your API has a low request limit that your mentor might hit, highlight this in the README and explain how to use your freeze-dried data. 
- [x]  The app handles all typical errors related to network calls — including server error response codes and no network connection — and keeps the user informed.  
- [x]  The app uses at least one way to save data: user defaults, plist, file, or keychain. Specify your method in the README.
- [x]  The app uses Swift Modern Concurrency, async/await, and MainActor appropriately to keep slow-running tasks off the main thread and to update the UI on the main thread. No dispatch queues or completion handlers
- [x]  The app communicates to the user whenever data is missing or empty, the reason for that condition — for example, data cannot be loaded, or the user hasn’t created any — and the action the user should perform to move forward. The app should have no blank screens, and the user should never feel “lost”.  
- [x]  All included screens work successfully without crashes or UI issues. 
- [x]  Views work for landscape and portrait orientations for the full range of iPhone sizes, including iPhone SE 2.
- [x]  Views work for both light and dark modes.
- [x]  Views work for landscape and portrait orientations for the full range of iPhone sizes, including iPhone SE 2.
- [x]  There are no obvious UI issues, like UI components overlapping or running off the screen.
- [x]  The code should be organized and easily readable. Project source files are organized in folders such as Views, Models, Networking etc. View components are abstracted into separate Views and source files.
- [x]  The project uses MVVM architecture: The Model includes at least one ObservableObject with at least one Published value that at least one view subscribes to. 
- [x]  Networking code is in a Service struct or class that can be instantiated by an ObservableObject.
- [x]  The project utilizes SwiftLint with Kodeco’s configuration file. Follow the instructions in the Kodeco Swift style guide to install it with Homebrew and the Build Run Script Phase. Don’t install it as a package. If you disable any rule for a line of code, explain why in a comment near the disable comment or, if it’s a general situation, explain in the README.  
- [x]  The app builds without Warnings or Errors. (Move your TODO warnings to a different branch.)
- [x]  The project has a test plan including both UI and unit tests, with a minimum of 50% code coverage, and all tests succeed. Make sure your test plan is in your repo.
- [x]  The app includes: A custom app icon.
- [x]  The app includes: An onboarding screen.
- [x]  The app includes: A custom display name.
- [x]  The app includes: At least one SwiftUI animation.
- [x]  The app includes: Styled text properties. SwiftUI modifiers are sufficient.







