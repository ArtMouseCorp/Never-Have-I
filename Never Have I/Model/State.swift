import Foundation

class State {
    
    // MARK: - Variables
    
    // Shared variable
    
    public static var shared: State = State()
    
    // State properties
    
    private var appLaunch: Int = 0
    
    // MARK: - Functions
    
    public func newAppLaunch() {
        self.appLaunch = self.getAppLaunchCount() + 1
        userDefaults.set(self.appLaunch, forKey: UDKeys.appLaunchCount)
    }
    
    public func getAppLaunchCount() -> Int {
        self.appLaunch = userDefaults.integer(forKey: UDKeys.appLaunchCount)
        return self.appLaunch
    }
    
    public func isFirstLaunch() -> Bool {
        return self.appLaunch == 1
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
