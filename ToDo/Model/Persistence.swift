//
//  Persistence.swift
//  ToDo
//
//  Created by Vedat Ozlu on 23.07.2023.
//

import CoreData

struct PersistenceController {
    // MARK: - 1. PERSISTENT CONTROLLER
    static let shared = PersistenceController() //Sets up the Model, Context, Coordinator

    
    // MARK: - 2. PERSISTENT CONTAINER
    let container: NSPersistentContainer

    // MARK: - 3. INITIALIZATION (load the persistent store)
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ToDo")
        if inMemory { //with this option data will not be stored on disk instead, it will be stored on memory / temporary storage. It is a good option for preview. To be able to use this we need to provide a different file url path.
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            // It loads the store (persistent or temporary)
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // MARK: - 4. PREVIEW
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true) // with the inMemory usage, we can create some sample datas and show it for preview purpose. These data will not be stored on disk.
        let viewContext = result.container.viewContext
        for i in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = "Sampe task number : \(i)"
            newItem.completion = false
            newItem.id = UUID()
        }
        do {
            try viewContext.save() //we are saving the data to memory / temporary storage for preview
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
