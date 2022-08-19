//
//  NoteView.swift
//  RIL Notes
//
//  Created by Srikanth Gimka on 17/08/22.
//

import SwiftUI

struct NoteView: View {
    @State var note: NoteModel = NoteModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>


    var body: some View {
        ScrollView{

            
            ExpandableTextView(placeholder: "Write a title ...", font: .systemFont(ofSize: 19, weight: .bold) ,text: $note.title, onCommit: {
                iHelper.saveNote(note)
            })
            ExpandableTextView(placeholder: "Write a note ...", font: .systemFont(ofSize: 14) ,text: $note.note, onCommit: {
                iHelper.saveNote(note)
            })



        }
        .navigationBarBackButtonHidden(true)

        .navigationBarItems(leading:
            Button(action: {
                DispatchQueue.main.async {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }) {
                Image(systemName: "chevron.backward")
                .aspectRatio(contentMode: .fit)
            }

        )
        .padding()

    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: NoteModel())
    }
}



