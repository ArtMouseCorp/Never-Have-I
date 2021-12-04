import UIKit
import Firebase
import FirebaseMessaging
import ApphudSDK
import StoreKit
import FacebookCore
import FacebookAEM
import AppTrackingTransparency
import AdSupport

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        State.shared.newAppLaunch()
        
        // Services connection
        
        self.integrateFirebase()
        self.integrateFirebaseMessaging(for: application)
        self.integrateApphud()
        self.integrateFacebook(for: application, with: launchOptions)
        
        // Fetch data
        
        Category.get {  }
        _ = DatabaseManager.shared
        _ = RCValues.sharedInstance
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        AEMReporter.configure(withNetworker: nil, appID: "300696808586130")
        AEMReporter.enable()
        AEMReporter.handle(url)
        
        return ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    
    @objc private func applicationDidBecomeActive() {
        AppEvents.shared.activateApp()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.requestTrackingAuthorization()
        }
    }
    
    // MARK: - Custom functions
    
    private func requestTrackingAuthorization() {
        if #available(iOS 14.5, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                switch status {
                case .authorized:
                    // Tracking authorization dialog was shown
                    // and we are authorized
                    print("Authorized")
                    let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                    Apphud.setAdvertisingIdentifier(idfa)
                case .denied:
                    // Tracking authorization dialog was
                    // shown and permission is denied
                    print("Denied")
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    print("Not Determined")
                case .restricted:
                    print("Restricted")
                @unknown default:
                    ()
                }
            })
        }
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
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("applicationDidBecomeActive"), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    private func integrateFacebook(for application: UIApplication, with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        Settings.shared.isAdvertiserTrackingEnabled = true
        Settings.shared.isAutoLogAppEventsEnabled = true
        Settings.shared.isAdvertiserIDCollectionEnabled = true
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        Apphud.addAttribution(data: [:], from: .facebook, callback: nil)
    }
    
    // MARK: - UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    func apphudShouldStartAppStoreDirectPurchase(_ product: SKProduct) -> ((ApphudPurchaseResult) -> Void) {
        // manage your UI here, show a progress hud, etc.
        let callback : ((ApphudPurchaseResult) -> Void) = { purchaseResult in
            // check the result, hide a progress hud, etc.
            if let subscription = purchaseResult.subscription, subscription.isActive() {
                
                print("Purchase Success: \(product.productIdentifier)")
                State.shared.isSubscribed = true
                
            }
            
        }
        return callback
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
