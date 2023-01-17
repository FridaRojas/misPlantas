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


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


