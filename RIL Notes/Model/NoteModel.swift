//
//  NoteModel.swift
//  RIL Notes
//
//  Created by Srikanth Gimka on 17/08/22.
//

import Foundation

let dateFormatter = DateFormatter()

class NoteModel{
    var id = ""
    var title = ""
    var note = ""
    var date = Date()
    var dateText: String {
        dateFormatter.dateFormat = "MMM d yyyy, h:mm a"
        return dateFormatter.string(from: date)
    }

    init(){
        self.id = ""
        self.title = ""
        self.note = ""
        self.date = Date()
    }
    
    init(entitiy: NoteEntity){
        self.id = entitiy.id ?? ""
        self.title = entitiy.title ?? ""
        self.note = entitiy.note ?? ""
        self.date = entitiy.date ?? Date()
    }
}
