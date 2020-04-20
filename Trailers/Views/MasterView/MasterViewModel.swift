import UIKit
import CoreData
import SwiftUI

class MasterViewModel {
  var masterCoordinator: MasterViewCoordinator!
  
  func startView(window: UIWindow?, context: NSManagedObjectContext, x: PageSelection) {
    let contentView = MasterView(x: x).environment(\.managedObjectContext, context)
    window?.rootViewController = UIHostingController(rootView: contentView)
    window?.makeKeyAndVisible()
  }
  
  func goToMain() {
    let window = UIApplication.shared.windows.first
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    startView(window: window, context: context, x: .main)
  }
}
