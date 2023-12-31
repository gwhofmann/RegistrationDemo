//
//  RegistrationHandlerTests.swift
//  RegistrationDemoTests
//
//  Created by Gregor Hofmann on 16.12.23.
//

import XCTest
@testable import RegistrationDemo

final class RegistrationHandlerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func getRegistrationHandler() -> RegistrationHandler {
        return RegistrationHandler()
    }
    
    func testIsValidName_EmptyName_ReturnsFalse() throws {
        let registrationHandler = getRegistrationHandler()
        let result = registrationHandler.isValidName(name: "")
        XCTAssertFalse(result)
    }
    
    func testIsValidName_NonEmptyName_ReturnsTrue() throws {
        let registrationHandler = getRegistrationHandler()
        let result = registrationHandler.isValidName(name: "Name")
        XCTAssertTrue(result)
    }
    
    func testIsValidEmail_EmailWithoutAt_ReturnsFalse() throws {
        let registrationHandler = getRegistrationHandler()
        let result = registrationHandler.isValidEmail(email: "name_domain.com")
        XCTAssertFalse(result)
    }
    
    func testIsValidEmail_EmailWithNoDotInDomain_ReturnsFalse() throws {
        let registrationHandler = getRegistrationHandler()
        let result = registrationHandler.isValidEmail(email: "name@domain_com")
        XCTAssertFalse(result)
    }
    
    func testIsValidEmail_EmailWithNoCharactersBeforeDotInDomain_ReturnsFalse() throws {
        let registrationHandler = getRegistrationHandler()
        let result = registrationHandler.isValidEmail(email: "name@.com")
        XCTAssertFalse(result)
    }
    
    func testIsValidEmail_EmailWithFewerThanTwoCharactersInTopLevelDomain_ReturnsFalse() throws {
        let registrationHandler = getRegistrationHandler()
        let result = registrationHandler.isValidEmail(email: "name@a.c")
        XCTAssertFalse(result)
    }
    
    func testIsValidEmail_MinimalValidEmail_ReturnsTrue() throws {
        let registrationHandler = getRegistrationHandler()
        let result = registrationHandler.isValidEmail(email: "a@b.ch")
        XCTAssertTrue(result)
    }
    
    func testIsValidDateOfBirth_DateOfBirthBefore1Jan1900_ReturnsFalse() throws {
        let registrationHandler = getRegistrationHandler()
        let dateComponents = DateComponents(year: 1899, month: 12, day: 31)
        let date = Calendar.current.date(from: dateComponents)!
        let result = registrationHandler.isValidDateOfBirth(dateOfBirth: date)
        XCTAssertFalse(result)
    }
    
    func testValidDateOfBirth_DateOfBirthLowerEdgeDay_ReturnsTrue() throws {
        let registrationHandler = getRegistrationHandler()
        let dateComponents = DateComponents(year: 1900, month: 1, day: 1)
        let date = Calendar.current.date(from: dateComponents)!
        let result = registrationHandler.isValidDateOfBirth(dateOfBirth: date)
        XCTAssertTrue(result)
    }
    
    func testValidDateOfBirth_DateOfBirthUpperEdgeDay_ReturnsTrue() throws {
        let registrationHandler = getRegistrationHandler()
        let dateComponents = DateComponents(year: 2022, month: 12, day: 31)
        let date = Calendar.current.date(from: dateComponents)!
        let result = registrationHandler.isValidDateOfBirth(dateOfBirth: date)
        XCTAssertTrue(result)
    }
    
    func testIsValidDateOfBirth_DateOfBirthAfter31Dec2022_ReturnsFalse() throws {
        let registrationHandler = getRegistrationHandler()
        let dateComponents = DateComponents(year: 2023, month: 1, day: 1)
        let date = Calendar.current.date(from: dateComponents)!
        let result = registrationHandler.isValidDateOfBirth(dateOfBirth: date)
        XCTAssertFalse(result)
    }
    
    func testIsValidDateOfBirth_ValidDate_ReturnsTrue() throws {
        let registrationHandler = getRegistrationHandler()
        let dateComponents = DateComponents(year: 1990, month: 5, day: 17)
        let date = Calendar.current.date(from: dateComponents)!
        let result = registrationHandler.isValidDateOfBirth(dateOfBirth: date)
        XCTAssertTrue(result)
    }
    
    func testIsValidRegistrationData_ValidData_ReturnsTrue() throws {
        let registrationHandler = getRegistrationHandler()
        let dobDay = 17
        let dobMonth = 5
        let dobYear = 1990
        let email = "a@b.ch"
        let name = "Name"
        let data = RegistrationData(name: name, email: email, dateOfBirthDay: dobDay, dateOfBirthMonth: dobMonth, dateOfBirhYear: dobYear)
        let result = registrationHandler.isValidRegistrationData(data: data)
        XCTAssertTrue(result)
    }
    
    func testIsValidRegistrationData_InvalidName_ReturnsFalse() throws {
        let registrationHandler = getRegistrationHandler()
        let dobDay = 17
        let dobMonth = 5
        let dobYear = 1990
        let email = "a@b.ch"
        let name = ""
        let data = RegistrationData(name: name, email: email, dateOfBirthDay: dobDay, dateOfBirthMonth: dobMonth, dateOfBirhYear: dobYear)
        let result = registrationHandler.isValidRegistrationData(data: data)
        XCTAssertFalse(result)
    }
    
    func testIsValidRegistrationData_InvalidEmail_ReturnsFalse() throws {
        let registrationHandler = getRegistrationHandler()
        let dobDay = 17
        let dobMonth = 5
        let dobYear = 1990
        let email = "a@ch"
        let name = "Name"
        let data = RegistrationData(name: name, email: email, dateOfBirthDay: dobDay, dateOfBirthMonth: dobMonth, dateOfBirhYear: dobYear)
        let result = registrationHandler.isValidRegistrationData(data: data)
        XCTAssertFalse(result)
    }
    
    func testIsValidRegistrationData_InvalidDoB_ReturnsFalse() throws {
        let registrationHandler = getRegistrationHandler()
        let dobDay = 17
        let dobMonth = 5
        let dobYear = 2023
        let email = "a@b.ch"
        let name = "Name"
        let data = RegistrationData(name: name, email: email, dateOfBirthDay: dobDay, dateOfBirthMonth: dobMonth, dateOfBirhYear: dobYear)
        let result = registrationHandler.isValidRegistrationData(data: data)
        XCTAssertFalse(result)
    }

}
