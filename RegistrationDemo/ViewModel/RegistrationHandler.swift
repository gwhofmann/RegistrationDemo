//
//  RegistrationHandler.swift
//  RegistrationDemo
//
//  Created by Gregor Hofmann on 16.12.23.
//

import Foundation
import SwiftUI

class RegistrationHandler: ObservableObject {
    
    @Published var registrationData: RegistrationData = RegistrationData(name: "", email: "", dateOfBirth: Date.now)
    
    var userDefaults = UserDefaults.standard
    
    var validRegistrationDataPresent: Bool {
        isValidRegistrationData(data: registrationData)
    }
    
    func persistRegistrationData(registrationData: RegistrationData) {
        userDefaults.set(registrationData.name, forKey: "registrationName")
        userDefaults.set(registrationData.email, forKey: "registrationEmail")
        
        let dobComponents = Calendar.current.dateComponents([.year, .month, .day], from: registrationData.dateOfBirth)
        let dobDay = dobComponents.day
        let dobMonth = dobComponents.month
        let dobYear = dobComponents.year
        userDefaults.set(dobYear, forKey: "registrationDoBYear")
        userDefaults.set(dobMonth, forKey: "registrationDoBMonth")
        userDefaults.set(dobDay, forKey: "registrationDoBDay")

    }
    
    func getPersistedRegistrationData() -> RegistrationData {
        let name = userDefaults.string(forKey: "registrationName") ?? ""
        let email = userDefaults.string(forKey: "registrationEmail") ?? ""
        let dobDay = userDefaults.integer(forKey: "registrationDoBDay")
        let dobMonth = userDefaults.integer(forKey: "registrationDoBMonth")
        let dobYear = userDefaults.integer(forKey: "registrationDoBYear")
        guard dobDay != 0 && dobMonth != 0 && dobYear != 0 else {
            // Non-set keys are returned as 0. As 0 is never a valid value for a day, month or year, return the default date (now)
            return RegistrationData(name: name, email: email, dateOfBirth: .now)
        }
        let dateOfBirthComponents = DateComponents(year: dobYear, month: dobMonth, day: dobDay)
        let dateOfBirth = Calendar.current.date(from: dateOfBirthComponents)
        
        return RegistrationData(name: name, email: email, dateOfBirth: dateOfBirth ?? .now)
    }
    
    func isValidName(name: String) -> Bool {
        return !name.isEmpty
    }
    
    func isValidEmail(email: String) -> Bool {
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
        return isValidName(name: data.name) &&
        isValidEmail(email: data.email) && isValidDateOfBirth(dateOfBirth: data.dateOfBirth)
    }
    
    
}
