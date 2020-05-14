import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  var persistence: Persistence!
  var helper: Helper!
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    persistence = Persistence()
    helper = Helper()
    
    let context = persistence.persistentContainer.viewContext
    let predicate = NSPredicate(format: "name='\(helper.user.name)'")
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    fetchRequest.predicate = predicate
    
    do {
      let users = try context.fetch(fetchRequest) as! [User]
      if users.count == 1 {
        print(users)
        deleteLogin(user: users.first!)
      } else  {
        print("There is an error we have to handle")
      }
    } catch {
      print("There is an error we have to handle")
    }
  }
  
  func deleteLogin(user: User) {
    persistence = Persistence()
    user.setValue(false, forKey: "login")
    persistence.saveContext()
  }
}

