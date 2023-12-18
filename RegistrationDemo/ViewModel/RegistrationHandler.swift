//
//  RegistrationHandler.swift
//  RegistrationDemo
//
//  Created by Gregor Hofmann on 16.12.23.
//

import Foundation
import SwiftUI

class RegistrationHandler: ObservableObject {
    
    @Published var registrationData: RegistrationData = RegistrationData(name: "", email: "", dateOfBirth: Date())
    
    var validRegistrationDataPresent: Bool {
        isValidName(name: registrationData.name) && isValidEmail(email: registrationData.email) && isValidDateOfBirth(dateOfBirth: registrationData.dateOfBirth)
    }
    
    func persistRegistrationData() {
        
    }
    
    func getPersistedRegistrationData() -> RegistrationData {
        return RegistrationData(name: "", email: "", dateOfBirth: Date())
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
    
    
}
