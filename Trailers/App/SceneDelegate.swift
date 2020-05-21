import UIKit
import SwiftUI
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  private var appCoordinator: AppCoordinator!
  var persistence: Persistence!
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    let fm = FileManager.default
    
    let storeURL = fm.urls(for: .documentDirectory, in: .userDomainMask)
    let sqliteURL = storeURL[0].appendingPathComponent("Trailers.sqlite")
    print(sqliteURL)
    
    persistence = Persistence()
    let context = persistence.persistentContainer.viewContext
    
    checkFalseLogin()
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      self.window = window
      appCoordinator = AppCoordinator(window: window, context: context)
      appCoordinator.start()
    }
  }
  
  func sceneDidEnterBackground(_ scene: UIScene) {
    
    Persistence().saveContext()
  }
  
  func windowScene(_ windowScene: UIWindowScene, didUpdate previousCoordinateSpace: UICoordinateSpace, interfaceOrientation previousInterfaceOrientation: UIInterfaceOrientation, traitCollection previousTraitCollection: UITraitCollection) {
    
  }
  
  func checkFalseLogin() {
    persistence = Persistence()
    let context = persistence.persistentContainer.viewContext
    
    let predicate = NSPredicate(format: "isLogin == YES")
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    fetchRequest.predicate = predicate
    
    do {
      let users = try context.fetch(fetchRequest) as! [User]
      if users.count > 0 {
        for user in users {
          user.setValue(false, forKey: "isLogin")
        }
        persistence.saveContext()
      } else  {
        print("There is no false login")
      }
    } catch {
      print("There is an error we have to handle")
    }
  }
}

