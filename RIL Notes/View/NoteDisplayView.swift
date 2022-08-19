//
//  NoteDisplayView.swift
//  RIL Notes
//
//  Created by Srikanth Gimka on 17/08/22.
//

import SwiftUI

struct NoteDisplayView: View {
    @State var note: NoteModel = NoteModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text(note.title).font(.headline).padding(.top, 10)
            Text(note.note).font(.system(size: 11)).lineLimit(nil).multilineTextAlignment(.leading).padding(.top, 5)
            Text(note.dateText).font(.system(size: 9)).padding(.top, 5)
        }
    }
}

struct NoteDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDisplayView()
    }
}
