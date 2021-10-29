import UIKit
import Firebase
import FirebaseMessaging
import ApphudSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        State.shared.newAppLaunch()
        
        // Services connection
        
        self.integrateFirebase()
        self.integrateFirebaseMessaging(for: application)
        self.integrateApphud()
        
        // Fetch data
        
        Category.get {  }
        _ = DatabaseManager.shared
        _ = RCValues.sharedInstance
        
        return true
    }
    
    // MARK: - Services integration functions
    
    private func integrateFirebase() {
        FirebaseApp.configure()
    }
    
    private func integrateFirebaseMessaging(for application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
    }
    
    private func integrateApphud() {
        Apphud.enableDebugLogs()
        Apphud.start(apiKey: Config.Apphud.apiKey)
    }
    
    // MARK: - UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
                                @escaping (UNNotificationPresentationOptions) -> Void) {
        process(notification)
        if #available(iOS 14.0, *) {
            completionHandler([[.banner, .sound]])
        } else {
            completionHandler([[.alert, .sound]])
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        process(response.notification)
        completionHandler()
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    private func process(_ notification: UNNotification) {
        let userInfo = notification.request.content.userInfo
        Messaging.messaging().appDidReceiveMessage(userInfo)
    }
    
}

// MARK: - MessagingDelegate

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging,
                   didReceiveRegistrationToken fcmToken: String?) {
        let tokenDict = ["token": fcmToken ?? ""]
        print("FCMToken:", fcmToken ?? "")
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: tokenDict
        )
    }
}

/*
 //           _._
 //        .-'   `
 //      __|__
 //     /     \
 //     |()_()|
 //     \{o o}/
 //      =\o/=
 //       ^ ^
 */
