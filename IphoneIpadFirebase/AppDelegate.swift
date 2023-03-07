//
//  AppDelegate.swift
//  IphoneIpadFirebase
//
//  Created by Frida Rojas Alarcon on 16/01/23.
//

import Foundation
import UIKit
import SwiftUI
import FirebaseCore
import GoogleSignIn


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        //GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
    -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}


