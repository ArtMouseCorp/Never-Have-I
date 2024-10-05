import Foundation

class State {
    
    // MARK: - Variables
    
    // Shared variable
    
    public static var shared: State = State()
    
    // State properties
    
    private var appLaunch: Int = 0
    
    public var isSubscribed: Bool = false
    
    public var selectedCategories: [Category] = []
        
    // MARK: - Functions
    
    public func setCustomLanguageChange(to bool: Bool) {
        userDefaults.set(bool, forKey: UDKeys.isCustomLanguageChange)
    }
    
    public func isCustomLanguageChange() -> Bool {
        return userDefaults.bool(forKey: UDKeys.isCustomLanguageChange)
    }
    
    public func getLanguageCode() -> Language.Code {
        var code = Bundle.main.preferredLocalizations.first ?? "en"
        
        if self.isCustomLanguageChange() {
            code = userDefaults.string(forKey: UDKeys.language) ?? "en"
        }
        
        return Language.Code.init(code)
    }
    
    public func setLanguage(to languageCode: Language.Code) {
        userDefaults.set(languageCode.rawValue, forKey: UDKeys.language)
        
        // Fetch new data
        Category.get() {}
    }
    
    public func newAppLaunch() {
        self.appLaunch = self.getAppLaunchCount() + 1
        userDefaults.set(self.appLaunch, forKey: UDKeys.appLaunchCount)
        self.isFirstLaunch() ? self.setCustomLanguageChange(to: false) : ()
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
