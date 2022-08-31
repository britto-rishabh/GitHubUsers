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
    
    static func hasNote(for id:Int32) -> Bool {
        let fetchUserNote: NSFetchRequest<UserNote> = UserNote.fetchRequest()
        fetchUserNote.predicate = NSPredicate(format: "id = \(id)")
        let results = (try? context.count(for: fetchUserNote)) ?? 0

        if results > 0 {
            return true
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
}
