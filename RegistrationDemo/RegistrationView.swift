//
//  RegistrationView.swift
//  RegistrationDemo
//
//  Created by Gregor Hofmann on 16.12.23.
//

import SwiftUI

struct RegistrationView: View {
    @ObservedObject var registrationHandler: RegistrationHandler
    
    @State private var nameEntry = ""
    @State private var emailEntry = ""
    @State private var dobEntry = Date.now
    
    func commitInput() {
        guard registrationHandler.isValidName(name: nameEntry) &&
                registrationHandler.isValidEmail(email: emailEntry) &&
                registrationHandler.isValidDateOfBirth(dateOfBirth: dobEntry) else {
            return
        }
        registrationHandler.registrationData = RegistrationData(name: nameEntry, email: emailEntry, dateOfBirth: dobEntry)
        registrationHandler.persistRegistrationData()
    }
    
    var body: some View {
        VStack{
            Text("Registrierung").font(.title)
            Spacer()
            Text("Um dich zu registrieren, gib' bitte deinen Namen, deine Email-Adresse und dein Geburtsdatum ein.").padding()
            TextField("Name", text: $nameEntry)
                .textFieldStyle(.roundedBorder)
                .textContentType(.name)
                .keyboardType(.default)
                .autocorrectionDisabled()
                .padding(.horizontal).padding()
            TextField("Email-Adresse", text: $emailEntry)
                .textFieldStyle(.roundedBorder)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .padding(.horizontal)
                .padding()
            DatePicker("Geburtsdatum:", selection: $dobEntry, displayedComponents: .date)
                .padding(.horizontal)
                .padding()
            Spacer()
            Button(action: commitInput){
                Text("Registrieren").font(.title2)
            }.padding()
            
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(registrationHandler: RegistrationHandler())
    }
}
