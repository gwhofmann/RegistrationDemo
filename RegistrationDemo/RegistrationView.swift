//
//  RegistrationView.swift
//  RegistrationDemo
//
//  Created by Gregor Hofmann on 16.12.23.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var registrationHandler: RegistrationHandler
    
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
        withAnimation{
            nameEntryAttempted = true
            emailEntryAttempted = true
            dobEntryAttempted = true
            let dobComponents = Calendar.current.dateComponents([.year, .month, .day], from: dobEntry)
            let registrationData = RegistrationData(name: nameEntry, email: emailEntry, dateOfBirthDay: dobComponents.day ?? 0, dateOfBirthMonth: dobComponents.month ?? 0, dateOfBirhYear: dobComponents.year ?? 0)
            guard registrationHandler.isValidRegistrationData(data: registrationData) else {
                return
            }
            registrationHandler.registrationData = registrationData
            registrationHandler.persistRegistrationData(registrationData: registrationData)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack{
                Text("Registrierung").font(.title)
                Text("Um dich zu registrieren, gib' bitte deinen Namen, deine Email-Adresse und dein Geburtsdatum ein.").padding(.vertical)
                VStack{
                    TextField("", text: $nameEntry, prompt: Text("Name").foregroundColor(Color("InputPlaceholderColour")))
                        .onSubmit {
                            withAnimation{
                                nameEntryAttempted = true
                            }
                        }
                        .textFieldStyle(.plain)
                        .textContentType(.name)
                        .keyboardType(.default)
                        .autocorrectionDisabled()
                        .padding().background(RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1.5)
                            .foregroundColor(nameEntryAttempted && !nameEntryIsValid ? .red : .primary))
                        .padding(.horizontal)
                    if nameEntryAttempted && !nameEntryIsValid {
                        Text("Bitte gib' einen Namen ein.").foregroundColor(.red)
                    }
                }.padding()
                VStack{
                    TextField("", text: $emailEntry, prompt: Text("Email-Adresse").foregroundColor(Color("InputPlaceholderColour")))
                        .onSubmit {
                            withAnimation{
                                emailEntryAttempted = true
                            }
                        }
                        .textFieldStyle(.plain)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding().background(RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1.5)
                            .foregroundColor(emailEntryAttempted && !emailEntryIsValid ? .red : .primary))
                        .padding(.horizontal)

                    if emailEntryAttempted && !emailEntryIsValid {
                        Text("Bitte gib' eine gültige Email-Adresse ein.").foregroundColor(.red)
                    }
                }.padding()
                VStack{
                    ViewThatFits{
                        DatePicker(selection: $dobEntry, displayedComponents: .date){
                            Text("Geburtsdatum:")                            .foregroundColor(dobEntryAttempted && !dobEntryIsValid ? .red : .primary)
                        }
                        VStack{
                            Text("Geburtsdatum:")                            .foregroundColor(dobEntryAttempted && !dobEntryIsValid ? .red : .primary)
                            DatePicker(selection: $dobEntry, displayedComponents: .date){
                            }.fixedSize()
                        }
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
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView().environmentObject(RegistrationHandler())
    }
}
