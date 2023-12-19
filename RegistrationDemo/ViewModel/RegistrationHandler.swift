//
//  RegistrationHandler.swift
//  RegistrationDemo
//
//  Created by Gregor Hofmann on 16.12.23.
//

import Foundation
import SwiftUI

class RegistrationHandler: ObservableObject {
    
    @Published var registrationData: RegistrationData = RegistrationData(name: "", email: "", dateOfBirthDay: 0, dateOfBirthMonth: 0, dateOfBirhYear: 0)
    
    var userDefaults = UserDefaults.standard
    
    var validRegistrationDataPresent: Bool {
        isValidRegistrationData(data: registrationData)
    }
    
    func persistRegistrationData(registrationData: RegistrationData) {
        userDefaults.set(registrationData.name, forKey: "registrationName")
        userDefaults.set(registrationData.email, forKey: "registrationEmail")
        
        userDefaults.set(registrationData.dateOfBirhYear, forKey: "registrationDoBYear")
        userDefaults.set(registrationData.dateOfBirthMonth, forKey: "registrationDoBMonth")
        userDefaults.set(registrationData.dateOfBirthDay, forKey: "registrationDoBDay")

    }
    
    func getPersistedRegistrationData() -> RegistrationData {
        let name = userDefaults.string(forKey: "registrationName") ?? ""
        let email = userDefaults.string(forKey: "registrationEmail") ?? ""
        let dobDay = userDefaults.integer(forKey: "registrationDoBDay")
        let dobMonth = userDefaults.integer(forKey: "registrationDoBMonth")
        let dobYear = userDefaults.integer(forKey: "registrationDoBYear")
        let dateOfBirthComponents = DateComponents(year: dobYear, month: dobMonth, day: dobDay)
        let dateOfBirth = Calendar.current.date(from: dateOfBirthComponents)
        
        return RegistrationData(name: name, email: email, dateOfBirthDay: dobDay, dateOfBirthMonth: dobMonth, dateOfBirhYear: dobYear)
    }
    
    func isValidName(name: String) -> Bool {
        return !name.isEmpty
    }
    
    func isValidEmail(email: String) -> Bool {
        // Comprehensive email address validation is somewhat complicated. Specific (and different) kinds of
        // characters are allowed in the user part and the domain the domain part. In principle, the user part
        // may include double quoted strings with considerable leeway and the domain part could be a local
        // domain (without dot) or even an IP address. In practice, these cases are probably not especially relevant
        // for real, good-faith users. However, unicode user names and domains may be important. The top-level
        // domain at least could be validated directly against the list of valid TLDs per
        // https://data.iana.org/TLD/tlds-alpha-by-domain.txt However this is subject to change.
        
        let components = email.split(separator: "@")
        if components.count != 2 {
            // The email address doesn't have exactly one @ dividing it into a username and domain component
            return false
        }
        let domainComponent = components[1]
        let domainSubComponents = domainComponent.split(separator: ".")
        if domainSubComponents.count < 2 {
            // the domain of the email address doesn't have at least one dot or the dot is at the start or end
            return false
        }
        if domainSubComponents.contains(where: { subComponent in
            subComponent.isEmpty
        }) {
            // any segment of the domain has fewer than one character
            return false
        }
        
        if domainSubComponents.last?.count ?? 0 < 2 {
            // the top-level domain has fewer than two characters
            return false
        }
        
        // everything checks out
        return true
    }
    
    func isValidDateOfBirth(dateOfBirth: Date) -> Bool {
        let minimumDateComponents = DateComponents(year: 1900, month: 1, day: 1)
        let maximumDateComponents = DateComponents(year: 2023, month: 1, day: 1)
        let minimumDate = Calendar.current.date(from: minimumDateComponents) ?? Date.now
        let maximumDate = Calendar.current.date(from: maximumDateComponents) ?? Date.now
        return (minimumDate..<maximumDate).contains(dateOfBirth)
    }
    
    func isValidRegistrationData(data: RegistrationData) -> Bool {
        guard let dateOfBirth = Calendar.current.date(from: DateComponents(year: data.dateOfBirhYear, month: data.dateOfBirthMonth, day: data.dateOfBirthDay)) else {
            // If the day, month, and year for the date of birth can't be converted into a date it is invalid
            // In particular, this applies to the default values of 0 for all fields.
            return false
        }
        
        return isValidName(name: data.name) &&
        isValidEmail(email: data.email) && isValidDateOfBirth(dateOfBirth: dateOfBirth)
    }
    
    
}
