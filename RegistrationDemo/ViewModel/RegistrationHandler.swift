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
        false
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
        return false
    }
    
    func isValidDateOfBirth(dateOfBirth: Date) -> Bool {
        let minimumDateComponents = DateComponents(year: 1900, month: 1, day: 1)
        let maximumDateComponents = DateComponents(year: 2023, month: 1, day: 1)
        let minimumDate = Calendar.current.date(from: minimumDateComponents) ?? Date.now
        let maximumDate = Calendar.current.date(from: maximumDateComponents) ?? Date.now
        return (minimumDate..<maximumDate).contains(dateOfBirth)
    }
    
    
}
