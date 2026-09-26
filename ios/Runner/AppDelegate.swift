import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Injected at build time from `.env` via Flutter's xcconfig files.
    if let mapsApiKey = Bundle.main.object(forInfoDictionaryKey: "MAPS_API_KEY") as? String,
       !mapsApiKey.isEmpty {
      GMSServices.provideAPIKey(mapsApiKey)
    } else {
      NSLog("MAPS_API_KEY is missing — add it to the .env file at the project root.")
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
