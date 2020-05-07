import Foundation
import CoreData

final class Helper {
  var persistence: Persistence!
  
  lazy var user: User = {
    persistence = Persistence()
    let context = persistence.persistentContainer.viewContext
    
    let predicate = NSPredicate(format: "isLogin == YES")
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    fetchRequest.predicate = predicate
    
    do {
      let users = try context.fetch(fetchRequest) as! [User]
      return users.first!
    } catch {
      print("There is an error we have to handle")
      return User()
    }
  }()
  
}
