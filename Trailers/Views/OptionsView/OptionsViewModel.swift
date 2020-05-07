import Foundation
import CoreData

class OptionsViewModel: ObservableObject {
  @Published var country: String
  @Published var explicit = true
  @Published var array = ["Yes", "No"]
  @Published var typeArray = ["movie", "shortFilm", "tvShow"]
  @Published var numberArray = Array<Int>(stride(from: 0, to: 251, by: 5))
  @Published var selectionIndex = 1
  @Published var explicitName1: String
  @Published var explicitName2: String
  @Published var number: String
  
  var persistence: Persistence!
  var helper: Helper!
  
  init() {
    country = Helper().user.options?.country ?? ""
    explicitName1 = Helper().user.options?.explicit == true ? "Yes" : "No"
    number = String(Int(Helper().user.options?.numberOfSearch ?? 0))
    explicitName2 = Helper().user.options?.type ?? "Type"
  }
  
  func saveOptions() {
    persistence = Persistence()
    helper = Helper()
    
    let context = persistence.persistentContainer.viewContext
    
    let predicate = NSPredicate(format: "name = '\(helper.user.name)'")
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    fetchRequest.predicate = predicate
    
    do {
      let users = try context.fetch(fetchRequest) as! [User]
      if users.count == 1 {
        if users.first!.options == nil {
          saveOptionsFirst()
        } else {
          updateOptions(user: users.first!)
        }
      }
    } catch {
      print("There is an error we have to handle")
    }
  }
  
  func saveOptionsFirst() {
    persistence = Persistence()
    helper = Helper()
    
    let context = persistence.persistentContainer.viewContext
    
    let options = NSEntityDescription.insertNewObject(forEntityName: "Options", into: context) as! Options
    
    options.id = UUID()
    options.country = country
    options.explicit = explicitName1 == "Yes" ? true : false
    options.numberOfSearch = Int16(Int(number ?? "0") ?? 0)
    options.type = explicitName2
    
    let predicate = NSPredicate(format: "name = '\(helper.user.name)'")
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    fetchRequest.predicate = predicate
    
    do {
      let users = try context.fetch(fetchRequest) as! [User]
      users.first!.setValue(options, forKey: "options")
    } catch {
      print("There is a problem!!")
    }
    
    persistence.saveContext()
  }
  
  func updateOptions(user: User) {
    persistence = Persistence()
    
    let context = persistence.persistentContainer.viewContext
    
    let predicate = NSPredicate(format: "id == %@", user.options!.id! as CVarArg )
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Options")
    fetchRequest.predicate = predicate
    print("NUMBER === \(number)")
    do {
      let options = try context.fetch(fetchRequest) as! [Options]
      if options.count == 1 {
        options.first!.setValue(country, forKey: "country")
        options.first!.setValue(explicitName1 == "Yes" ? true : false, forKey: "explicit")
        options.first!.setValue(Int16(Int(number ?? "0") ?? 0), forKey: "numberOfSearch")
        options.first!.setValue(explicitName2, forKey: "type")
        
        persistence.saveContext()
      } else  {
        print("There is a problem")
      }
    } catch {
      print("There is an error we have to handle")
    }
  }
}
