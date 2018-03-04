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
        window.rootViewController = UIViewController()

        self.window = window

        window.makeKeyAndVisible()

        let recipeURL = URL(string: "https://myfood-dev-as.azurewebsites.net/api/Recipes/f4a100f2-5e37-481e-be0b-4aa15fa6a29e")!

        URLSession.shared.dataTask(with: recipeURL) { (data, _, _) in
            guard let data = data else {
                return
            }

            guard let recipe = try? JSONDecoder().decode(RecipeInfo.self, from: data) else {
                return
            }

            DispatchQueue.main.async {
                let vc = RecipeViewController(recipe: recipe)

                window.rootViewController = vc
            }
        }.resume()

        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        completionHandler([.alert, .badge, .sound])
    }
}
