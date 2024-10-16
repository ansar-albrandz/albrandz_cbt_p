import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyA1bL9RQecZMr-Tv4tegqZOxTGRz7f8CJM")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
