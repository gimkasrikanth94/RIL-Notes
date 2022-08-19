//
//  NotesManager.swift
//  RIL Notes
//
//  Created by Srikanth Gimka on 17/08/22.
//

import Foundation
import UIKit
import CoreData


class NotesManager{
    
    public static let shared = NotesManager()
    var entityData: [NoteEntity] = []
 
    func saveDataFor(_ note: NoteModel){
        if !self.checkAvailability(note){
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let userEntity = NSEntityDescription.entity(forEntityName: "NoteEntity", in: managedContext)!
            
            
                let noteObj = NSManagedObject(entity: userEntity, insertInto: managedContext)
                    noteObj.setValue(note.id, forKeyPath: "id")
                    noteObj.setValue(note.title, forKeyPath: "title")
                    noteObj.setValue(note.note, forKey: "note")
                    noteObj.setValue(note.date, forKey: "date")
            
            do {
                try managedContext.save()
               
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }else{
            self.updateData(note)
        }
    }
    
    
    func retrieveData() {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteEntity")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            if let result = try managedContext.fetch(fetchRequest) as? [NoteEntity]{
                entityData = result
            }
            
        } catch {
            
            print("Failed")
        }
    }
    func checkAvailability(_ note: NoteModel) -> Bool{

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "NoteEntity")
            fetchRequest.predicate = NSPredicate(format: "id = %@", note.id)

        do
        {
            let test = try managedContext.fetch(fetchRequest)
            if test.count == 1 {
                return true
            }
            
            }
        catch
        {
            print(error)
        }
        
        
        return false
    }
    func updateData(_ note: NoteModel){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "NoteEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %@", note.id)

        do
        {
            let test = try managedContext.fetch(fetchRequest)
   
                let noteObjUpdate = test[0] as! NSManagedObject
            noteObjUpdate.setValue(note.id, forKeyPath: "id")
            noteObjUpdate.setValue(note.title, forKeyPath: "title")
            noteObjUpdate.setValue(note.note, forKey: "note")
            noteObjUpdate.setValue(note.date, forKey: "date")
                do{
                    try managedContext.save()
                }
                catch
                {
                    print(error)
                }
            }
        catch
        {
            print(error)
        }
        }
    
     func deleteData(_ note: NoteModel){
         
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
         

         let managedContext = appDelegate.persistentContainer.viewContext
         
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteEntity")
         fetchRequest.predicate = NSPredicate(format: "id = %@", note.id)

         do
         {
             let test = try managedContext.fetch(fetchRequest)
             
             let objectToDelete = test[0] as! NSManagedObject
             managedContext.delete(objectToDelete)
             
             do{
                 try managedContext.save()
             }
             catch
             {
                 print(error)
             }
             
         }
         catch
         {
             print(error)
         }
         }
    func fetchAllData() -> [NoteEntity] {
        
        self.retrieveData()
        return self.entityData.sorted(by: {($0.date ?? Date()) > ($1.date ?? Date())})
    }
    
    func deleteAllData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteEntity")
        fetchRequest.returnsObjectsAsFaults = false

        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in NoteEntity error : \(error) \(error.userInfo)")
        }

        _ = fetchAllData()
    }

}
