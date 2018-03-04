import Foundation
import UIKit
import UserNotifications

struct Notifications {
    static func register() {
        let center =  UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (result, error) in }
    }
    
    static func cancelAll() {
        let center =  UNUserNotificationCenter.current()

        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
    }
    
    static func show(text: String, after: Int) {
        let center =  UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = text
        content.subtitle = text
        content.body = text
        content.sound = UNNotificationSound.default()

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(after), repeats: false)

        let request = UNNotificationRequest(identifier: "ContentIdentifier", content: content, trigger: trigger)

        center.add(request) { error in
//            print(error)
        }
    }
}
