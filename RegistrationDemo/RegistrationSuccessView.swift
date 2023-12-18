//
//  RegistrationSuccessView.swift
//  RegistrationDemo
//
//  Created by Gregor Hofmann on 16.12.23.
//

import SwiftUI

struct RegistrationSuccessView: View {
    @EnvironmentObject var registrationHandler: RegistrationHandler
    
    var dateOfBirthText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: registrationHandler.registrationData.dateOfBirth)
    }
    
    var body: some View {
        VStack{
            Text("Danke für die Registrierung").font(.title)
            Spacer()
            Text(registrationHandler.registrationData.name).bold().padding()
            Text(registrationHandler.registrationData.email).bold().padding()
            Text(dateOfBirthText).bold().padding()
            Spacer()
        }.padding()
    }
}

struct RegistrationSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        let handler = RegistrationHandler()
        RegistrationSuccessView().environmentObject(handler).onAppear{
            handler.registrationData = RegistrationData(name: "Claudia Testmensch", email: "claudia.testmensch@testmail.com", dateOfBirth: Date(timeIntervalSince1970: 521646037))
        }
    }
}
