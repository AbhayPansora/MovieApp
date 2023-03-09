//
//  AppDelegate.swift
//  MoviesApp
//
//  Created by Abhay Pansora on 18/02/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController : UINavigationController?
    var applicationapp : UIApplication!
    var isVerifyOTPScreenOrNot = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        applicationapp = application
        //MARK: - Set navigation theame
        UINavigationBar.appearance().barTintColor = APP_WHITE_COLOR
        UINavigationBar.appearance().tintColor = APP_WHITE_COLOR
        UINavigationBar.appearance().isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : APP_BLACK_COLOR, NSAttributedString.Key.font: UIFont(name: FONT_BOLD, size: 18.0)!]
        if getBoolUserDefaultValue(KEY_IS_USER_LOGGED_IN){
            self.openSplashScreen(index: 1)
        }else{
            self.openSplashScreen(index: 0)
        }
        return true
    }
    func openSplashScreen(index: Int) {
        if index == 1{
            let VC = HomeVC(nibName: "HomeVC", bundle: nil)
            self.navigationController = UINavigationController(rootViewController: VC)
            self.window?.rootViewController = self.navigationController
            self.window?.makeKeyAndVisible()
        }else{
            let VC = SignUpVC(nibName: "SignUpVC", bundle: nil)
            self.navigationController = UINavigationController(rootViewController: VC)
            self.window?.rootViewController = self.navigationController
            self.window?.makeKeyAndVisible()
            
        }
    }
    
}

