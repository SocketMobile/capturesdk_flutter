import UIKit
import Flutter

class SceneDelegate: FlutterSceneDelegate {
  override func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    super.scene(scene, willConnectTo: session, options: connectionOptions)
    // EAAccessoryManager.showBluetoothAccessoryPicker only creates its window when the app
    // delegate has one, and silently shows nothing when it is nil, as it is under UIScene
    (UIApplication.shared.delegate as? FlutterAppDelegate)?.window = window
  }
}
