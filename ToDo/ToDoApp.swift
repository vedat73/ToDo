//
//  ToDoApp.swift
//  ToDo
//
//  Created by Vedat Ozlu on 23.07.2023.
//

import SwiftUI

@main
struct ToDoApp: App {
    let persistenceController = PersistenceController.shared
    @AppStorage("isDarkMode") private var isDarkMode : Bool = false
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext) //with this line of code, the managedObjectcontext is injected in the ContentView and its child files.
            // this viewContext will be used for saving, updating, deleting data
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
