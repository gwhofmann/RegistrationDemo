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
        return false
    }
    
    func isValidEmail(email: String) -> Bool {
        return false
    }
    
    func isValidDateOfBirth(dateOfBirth: Date) -> Bool {
        return false
    }
    
    
}
