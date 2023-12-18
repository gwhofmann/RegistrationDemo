//
//  ContentView.swift
//  RegistrationDemo
//
//  Created by Gregor Hofmann on 16.12.23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var registrationHandler: RegistrationHandler
    
    var body: some View {
        if registrationHandler.validRegistrationDataPresent {
            RegistrationSuccessView()
        } else {
            RegistrationView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(RegistrationHandler())
    }
}
