# NowPlaying
A project to demonstrate how handleRemoteNowPlayingActivity is no longer called

Previously, when an iPhone application starts playback, it launches the corresponding watch application and calls `handleRemoteNowPlayingActivity()` on the ExtensionDelegate.

This no longer is true and this project demonstrates it.

* Load up the application on both the watch and the phone (must be actual devices, simulator doesn't work).
* After launching the app both on the phone and the watch, put the watch app in the background by tapping the crown.
* Tap play on the phone. 

Notice how the application is launched on the watch, but the text "Now Playing" is red. If `handleRemoteNowPlayingActivity()` would be called back properly, the text should be green.

Also notice, if you navigate to the "Now Playing" screen by tapping the text on the watch, you can still play and pause the phone application, indicating that the connection is there.
