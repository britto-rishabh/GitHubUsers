//
//  User+Note.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 31/08/22.
//

import Foundation

extension User{
    var hasNote:Bool{PersistenceManager.hasNote(for: Int32(id))}
    var note:String{PersistenceManager.note(for: Int32(id))}
}
