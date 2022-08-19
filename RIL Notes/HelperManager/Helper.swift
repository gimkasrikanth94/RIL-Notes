//
//  Helper.swift
//  RIL Notes
//
//  Created by Srikanth Gimka on 17/08/22.
//

import Foundation

let iHelper = Helper.sharedInstance()

class Helper: NSObject, ObservableObject {
    
    static var _Helper : Helper?
    
    class func sharedInstance() -> Helper {
        if (_Helper == nil)
        {
            _Helper = Helper()
        }
        
        return (_Helper)!
    }
    @Published  var notesList: [NoteEntity] = NotesManager.shared.fetchAllData()

    
    func saveNote(_ completion: NoteModel){
            completion.date = Date()
        if (completion.title == "" && completion.note == ""){
            NotesManager.shared.deleteData(completion)
        }else{
            if completion.id == ""{
                completion.id = UUID().uuidString
            }
            NotesManager.shared.saveDataFor(completion)
        }
        self.notesList = NotesManager.shared.fetchAllData()
    }
    func deleteNote(_ completion: NoteModel){
        NotesManager.shared.deleteData(completion)
        self.notesList = NotesManager.shared.fetchAllData()
    }
}
