//
//  RegistrationDemoApp.swift
//  RegistrationDemo
//
//  Created by Gregor Hofmann on 16.12.23.
//

import SwiftUI

@main
struct RegistrationDemoApp: App {
    @StateObject private var registrationHandler = RegistrationHandler()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(registrationHandler).onAppear{
                registrationHandler.registrationData = registrationHandler.getPersistedRegistrationData()
            }
        }
    }
}
