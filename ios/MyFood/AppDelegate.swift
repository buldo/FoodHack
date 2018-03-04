import UIKit
import AVFoundation
import UserNotifications
import Speech

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        application.isIdleTimerDisabled = true

        Notifications.register()
        
        UNUserNotificationCenter.current().delegate = self
        
        SFSpeechRecognizer.requestAuthorization { _ in }

        let window = UIWindow()
        window.rootViewController = SplashViewController()

        self.window = window

        window.makeKeyAndVisible()

        let recipesURL = URL(string: "https://myfood-dev-as.azurewebsites.net/api/Recipes")!

        URLSession.shared.dataTask(with: recipesURL) { (data, _, _) in
            guard let data = data else {
                return
            }

            guard let recipes = try? JSONDecoder().decode([RecipeListInfo].self, from: data) else {
                return
            }

            DispatchQueue.main.async {
                let vc = RecipeListViewController(recipes: recipes)
                let nc = UINavigationController(rootViewController: vc)
                nc.navigationBar.tintColor = #colorLiteral(red: 0.3393005133, green: 0.2195523679, blue: 0.3600926697, alpha: 1)

                window.rootViewController = nc
            }
        }.resume()

        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        completionHandler([.alert, .badge, .sound])
    }
}
