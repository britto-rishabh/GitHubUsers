//
//  PersistanceManager.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 30/08/22.
//

import UIKit
import CoreData

class PersistenceManager {

    static var context: NSManagedObjectContext {
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
       return appDelegate.persistentContainer.viewContext
    }
    
    
    
    static func profileViewed(for id:Int32) -> Bool {
        let fetchUserProfileViewed: NSFetchRequest<UserNote> = UserNote.fetchRequest()
        fetchUserProfileViewed.predicate = NSPredicate(format: "id = \(id)")
        if let results = (try? context.fetch(fetchUserProfileViewed)){
            if results.count > 0 , let viewed = results.first?.viewed, viewed == true {
                return true
            }
        }
        return false
    }
    
    static func updateProfileViewed(for id:Int32) {
        let userNote: UserNote!
        let fetchUserNote: NSFetchRequest<UserNote> = UserNote.fetchRequest()
        fetchUserNote.predicate = NSPredicate(format: "id = \(id)")
        if let results = try? context.fetch(fetchUserNote){
            if results.count == 0 {
                userNote = UserNote.init(context: context)
                userNote.id = id
            } else {
                userNote = results.first
            }
            userNote.viewed = true
            try? context.save()
        }
    }
    
    static func hasNote(for id:Int32) -> Bool {
        let fetchUserNote: NSFetchRequest<UserNote> = UserNote.fetchRequest()
        fetchUserNote.predicate = NSPredicate(format: "id = \(id)")
        if let results = try? context.fetch(fetchUserNote){
            if results.count > 0, let note = results.first?.note, note.isEmpty == false {
                return true
            }
        }
        
        return false
    }
    
    static func note(for id:Int32) -> String {
        let fetchUserNote: NSFetchRequest<UserNote> = UserNote.fetchRequest()
        fetchUserNote.predicate = NSPredicate(format: "id = \(id)")
        var note:String?
        if let results = try? context.fetch(fetchUserNote){
            if results.count > 0 {
                note = results.first?.note
            }
        }
        return note ?? ""
    }
    
    static func update(id:Int32,note:String) -> Void {
        let userNote: UserNote!
        let fetchUserNote: NSFetchRequest<UserNote> = UserNote.fetchRequest()
        fetchUserNote.predicate = NSPredicate(format: "id = \(id)")
        let results = try? context.fetch(fetchUserNote)

        if results?.count == 0 {
            userNote = UserNote.init(context: context)
        } else {
           // here you are updating
            userNote = results?.first
        }
        userNote.id = id
        userNote.note = note
        try? context.save()
    }
}
