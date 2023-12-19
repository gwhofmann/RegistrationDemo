//
//  RegistrationHandlerIntegrationTests.swift
//  RegistrationDemoTests
//
//  Created by Gregor Hofmann on 18.12.23.
//

import XCTest
@testable import RegistrationDemo

final class RegistrationHandlerIntegrationTests: XCTestCase {
    
    func getRegistrationHandler() -> RegistrationHandler {
        let defaults = UserDefaults(suiteName: "fakeTestDefaults")!
        cleanUserDefaults(userDefaults: defaults)
        let handler = RegistrationHandler()
        handler.userDefaults = defaults
        return handler
    }
    
    func cleanUserDefaults(userDefaults: UserDefaults) {
        let defaultKeys = userDefaults.dictionaryRepresentation().keys
        for key in defaultKeys{
            userDefaults.removeObject(forKey: key)
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        _ = getRegistrationHandler()
    }
    
    func testPersistence_PersistedRegistrationData_RetrievedCorrectly() throws {
        let registrationHandler = getRegistrationHandler()
        
        let dateComponents = DateComponents(year: 2023, month: 5, day: 17)
        let date = Calendar.current.date(from: dateComponents)!
        let inputRegistrationData = RegistrationData(name: "Name", email: "a@b.ch", dateOfBirthDay: 15, dateOfBirthMonth: 7, dateOfBirhYear: 1985)
        registrationHandler.persistRegistrationData(registrationData: inputRegistrationData)
        
        let outputRegistrationData = registrationHandler.getPersistedRegistrationData()
        
        let result = inputRegistrationData.name == outputRegistrationData.name
        && inputRegistrationData.email == outputRegistrationData.email
        && inputRegistrationData.dateOfBirthDay == outputRegistrationData.dateOfBirthDay
        && inputRegistrationData.dateOfBirthMonth == outputRegistrationData.dateOfBirthMonth
        && inputRegistrationData.dateOfBirhYear == outputRegistrationData.dateOfBirhYear
        
        XCTAssertTrue(result)
    }
    
    func testPersistence_NoPersistedRegistrationData_ReturnsEmpty() throws {
        let registrationHandler = getRegistrationHandler()
        
        let outputRegistrationData = registrationHandler.getPersistedRegistrationData()
        
        let result = outputRegistrationData.name == ""
        && outputRegistrationData.email == ""
        && outputRegistrationData.dateOfBirthDay == 0
        && outputRegistrationData.dateOfBirthMonth == 0
        && outputRegistrationData.dateOfBirhYear == 0
        XCTAssertTrue(result)
    }
    

}
