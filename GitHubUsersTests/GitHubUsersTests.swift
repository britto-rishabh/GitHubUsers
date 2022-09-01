//
//  GitHubUsersTests.swift
//  GitHubUsersTests
//
//  Created by Britto Thomas on 30/08/22.
//

import XCTest
@testable import GitHubUsers

class GitHubUsersTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testGetUserList() throws {
        let getUserList = GetUserList()
        let parameter = GetUserListParameter(id: 0)
        var users:[User]?
        let usersExpectation = expectation(description: "users")
        
        getUserList.call(parameter: parameter) {_users in
            users = _users;
            usersExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(users)
        }
    }
    
    func testGetUserProfile() throws {
        let getUserProfile = GetUserProfile()
        let parameter = GetUserProfileParameter(name: "mojombo")
        var userProfile:UserProfile?
        let userProfileExpectation = expectation(description: "userProfile")
        
        getUserProfile.call(parameter: parameter) {_userProfile in
            userProfile = _userProfile;
            userProfileExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(userProfile)
        }
    }
    
    func testGetUserNote() throws {
        let note = PersistenceManager.note(for: 1)
        XCTAssertNotNil(note)
    }
    
    func testUpdateUserNote() throws {
        PersistenceManager.update(id: 2, note: "Hello")
        let note = PersistenceManager.note(for: 2)
        XCTAssertEqual(note, "Hello")
    }
}
