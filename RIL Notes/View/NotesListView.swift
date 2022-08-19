//
//  NotesListView.swift
//  RIL Notes
//
//  Created by Srikanth Gimka on 17/08/22.
//

import SwiftUI
struct NotesListView: View {
    @State var items = iHelper.notesList
    @State var showAlert = false
    @State var itemToDelete: NoteModel?

    var alert: Alert {
        Alert(title: Text("Alert"),
              message: Text("Are you sure you want to delete this note?"),
              primaryButton: .destructive(Text("Delete"), action: {
            if let note = itemToDelete{
                iHelper.deleteNote(note)
                items = iHelper.notesList
            }
        }), secondaryButton: .cancel())
    }

    
    var body: some View {
        NavigationView {
            VStack{
                if items.count == 0{
                    Text("Click on \(Image(systemName: "square.and.pencil")) to take notes")
                        .font(.headline)
                }else{
                    Spacer()
                    List(items) { item in
                        let note = NoteModel(entitiy: item)
                        VStack(alignment: .leading) {
                            NavigationLink(destination: NoteView(note: note)) {
                                NoteDisplayView(note: note)
                            }
                        }.swipeActions {
                            Button("Delete") {
                                self.itemToDelete = note
                                self.showAlert = true
                            }
                            .tint(.red)
                        }
                        .alert(isPresented: $showAlert, content: {
                            alert
                        })
                    }
                }
            }
            .onAppear(){
                items.removeAll()
                DispatchQueue.main.async {
                    items = iHelper.notesList
                }
                
            }
            .navigationBarTitle("Notes")
            .navigationBarItems(trailing:
                NavigationLink(destination: NoteView(note: NoteModel())) {
                    Image(systemName: "square.and.pencil").imageScale(.large)
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())

    }
}

struct NotesListView_Previews: PreviewProvider {
    static var previews: some View {
        NotesListView()
    }
}
