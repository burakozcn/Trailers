import UIKit
import SwiftUI
import CoreData

class LoginViewModel: ObservableObject {
  private var loginCoordinator: LoginViewCoordinator!
  private var persistence: Persistence!
  
  func startView() {
    let window = UIApplication.shared.windows.first
    
    let contentView = LoginView()
    window?.rootViewController = UIHostingController(rootView: contentView)
    window?.makeKeyAndVisible()
  }
  
  func goToMasterView() {
    loginCoordinator = LoginViewCoordinator()
    loginCoordinator.goToMasterView()
  }
  
  func nameLogin(name: String) {
    persistence = Persistence()
    let context = persistence.persistentContainer.viewContext
    let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
    let predicate = NSPredicate(format: "name='\(name)'")
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    fetchRequest.sortDescriptors = [sortDescriptor]
    fetchRequest.predicate = predicate
    
    do {
      let users = try context.fetch(fetchRequest) as! [User]
      if users.count == 1 {
        users.first!.setValue(true, forKey: "isLogin")
        persistence.saveContext()
        
        login(user: users.first!)
      } else if users.count > 1 {
        print("There is an error we have to handle")
      } else if users.count == 0 {
        signUp(name: name)
      }
    } catch {
      print("There is an error we have to handle")
    }
  }
  
  func login(user: User) {
    Helper()
    goToMasterView()
  }
  
  func signUp(name: String) {
    persistence = Persistence()
    let context = persistence.persistentContainer.viewContext
    
    let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
    
    user.name = "\(name)"
    
    persistence.saveContext()
    nameLogin(name: user.name)
  }
}
