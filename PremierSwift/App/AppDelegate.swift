import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        /// start new window
        window = UIWindow()
        let navigationController = UINavigationController()
        /// cannot force ungrap window's value, if for any reason window is nil it will crash
        window?.rootViewController = navigationController
        let coordinator = AppCoordinator(navigationController: navigationController)
        coordinator.start()
        self.coordinator = coordinator
        window?.makeKeyAndVisible()
        return true
    }
}
