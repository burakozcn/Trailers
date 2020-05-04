import CoreData

class Persistence: NSObject {

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Trailers")
    
    let persistentStoreURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("Trailers.sqlite")
    let persistentStoreDescription = NSPersistentStoreDescription(url: persistentStoreURL)
    persistentStoreDescription.type = NSSQLiteStoreType
    persistentStoreDescription.shouldMigrateStoreAutomatically = true
    persistentStoreDescription.shouldInferMappingModelAutomatically = false
    container.persistentStoreDescriptions = [persistentStoreDescription]
    
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    
    return container
  }()
  
  func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
