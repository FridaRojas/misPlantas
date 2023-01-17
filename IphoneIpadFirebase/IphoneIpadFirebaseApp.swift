//
//  IphoneIpadFirebaseApp.swift
//  IphoneIpadFirebase
//
//  Created by Jorge Maldonado Borbón on 19/01/21.
//

import SwiftUI

@main
struct IphoneIpadFirebaseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        let login = FirebaseViewModel()
        WindowGroup {
            
            ContentView().environmentObject(login)
            //Home()
        }
    }
}
