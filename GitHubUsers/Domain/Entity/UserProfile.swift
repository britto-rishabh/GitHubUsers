//
//  UserProfile.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 30/08/22.
//

import Foundation

struct UserProfile {
    let login: String
    let id: Int
    let avatarURL: String
    let name: String
    let company: String?
    let blog: String?
    let followers: Int
    let following: Int
}
