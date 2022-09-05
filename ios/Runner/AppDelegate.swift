import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

//@UIApplicationMain
//@objc class AppDelegate: FlutterAppDelegate {
//    override func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
//    ) -> Bool {
//        let controller = window.rootViewController as? FlutterViewController
//        let nativeChannel = FlutterMethodChannel(
//            name: "flutter.native/helper",
//            binaryMessenger: controller)
//        weak var weakSelf = self
//        nativeChannel.methodCallHandler = { call, result in
//            if "fetchLabels" == call?.method {
//                let strNative = weakSelf?.helloFromNativeCode()
//                result(strNative)
//            } else {
//                result(FlutterMethodNotImplemented)
//            }
//        }
//        GeneratedPluginRegistrant.register(withRegistry: self)
//        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//    }
//
//    func fetchLabels(uri:String) -> String? {
////        let imageRaw: UIImage = UIImage(data: uri)
////        let image = VisionImage(image: imageRaw)
////        visionImage.orientation = image.imageOrientation
////
////         let options = ImageLabelerOptions()
////         options.confidenceThreshold = 0.7
////         let labeler = ImageLabeler.imageLabeler(options: options)
////
////        labeler.process(image) { labels, error in
////            guard error == nil, let labels = labels else { return }
////
////            // Task succeeded.
////            // ...
////        }
//        return null;
//    }
//}
