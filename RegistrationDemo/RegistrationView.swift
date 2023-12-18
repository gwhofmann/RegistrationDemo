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
    
    @State private var nameEntryAttempted = false
    @State private var emailEntryAttempted = false
    @State private var dobEntryAttempted = false
    
    var nameEntryIsValid: Bool{
        return registrationHandler.isValidName(name: nameEntry)
    }
    
    var emailEntryIsValid: Bool{
        return registrationHandler.isValidEmail(email: emailEntry)
    }
    
    var dobEntryIsValid: Bool{
        return registrationHandler.isValidDateOfBirth(dateOfBirth: dobEntry)
    }
    
    func commitInput() {
        nameEntryAttempted = true
        emailEntryAttempted = true
        dobEntryAttempted = true
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
            Text("Um dich zu registrieren, gib' bitte deinen Namen, deine Email-Adresse und dein Geburtsdatum ein.")
            VStack{
                TextField("Name", text: $nameEntry)
                    .onSubmit {
                        nameEntryAttempted = true
                    }
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.name)
                    .keyboardType(.default)
                    .autocorrectionDisabled()
                    .padding(.horizontal)
                if nameEntryAttempted && !nameEntryIsValid {
                    Text("Bitte gib' einen Namen ein.").foregroundColor(.red)
                }
            }.padding()
            VStack{
                TextField("Email-Adresse", text: $emailEntry)
                    .onSubmit {
                        emailEntryAttempted = true
                    }
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal)

                if emailEntryAttempted && !emailEntryIsValid {
                    Text("Bitte gib' eine gültige Email-Adresse ein.").foregroundColor(.red)
                }
            }.padding()
            VStack{
                DatePicker("Geburtsdatum:", selection: $dobEntry, displayedComponents: .date)
                    .onSubmit {
                        dobEntryAttempted = true
                    }
                    .padding(.horizontal)
                
                if dobEntryAttempted && !dobEntryIsValid {
                    Text("Bitte setze ein gültiges Geburtsdatum zwischen dem 1.1.1900 und dem 31.12.2022.").foregroundColor(.red)
                }
            }.padding()
            Spacer()
            Button(action: commitInput){
                Text("Registrieren").font(.title2)
            }.padding()
            
        }.padding(.horizontal)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(registrationHandler: RegistrationHandler())
    }
}
