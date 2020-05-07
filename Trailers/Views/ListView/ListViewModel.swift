import Foundation
import SwiftUI
import CoreData

class ListViewModel {
  private let network = NetworkManagement()
  private var listView: ListView!
  private var coordinator: ListViewCoordinator!
  private var persistence: Persistence!
  private var helper: Helper!
  let results: Results
  
  init(results: Results) {
    self.results = results
    ListView().environmentObject(results)
  }
  
  func saveResults() {
    persistence = Persistence()
    helper = Helper()
    
    let context = persistence.persistentContainer.viewContext
    
    let predicate = NSPredicate(format: "name = '\(helper.user.name)'")
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    fetchRequest.predicate = predicate
    
    do {
      let users = try context.fetch(fetchRequest) as! [User]
      if users.count == 1 {
        if users.first!.results == nil {
          saveResultsFirst()
        } else {
          updateResults(user: users.first!)
        }
      }
    } catch {
      print("There is an error we have to handle")
    }
  }
  
  func saveResultsFirst() {
    persistence = Persistence()
    helper = Helper()
    
    let context = persistence.persistentContainer.viewContext
    
    let predicate = NSPredicate(format: "name = '\(helper.user.name)'")
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    fetchRequest.predicate = predicate
    
    for i in 0..<results.results.count {
      let resultModels = NSEntityDescription.insertNewObject(forEntityName: "ResultModel", into: context) as! ResultModel
      
      resultModels.artistName = results.results[i].artistName
      resultModels.collectionName = results.results[i].collectionName
      resultModels.country = results.results[i].country
      resultModels.previewUrl = results.results[i].previewUrl
      resultModels.artworkUrl30 = results.results[i].artworkUrl30
      resultModels.primaryGenreName = results.results[i].primaryGenreName
      resultModels.releaseDate = results.results[i].releaseDate
      resultModels.trackName = results.results[i].trackName
      
      do {
        let users = try context.fetch(fetchRequest) as! [User]
        users.first!.setValue(resultModels, forKey: "results")
      } catch {
        print("There is a problem!!")
      }
      
      persistence.saveContext()
    }
  }
  
  func updateResults(user: User) {
    
  }
  
  func goToMainView() {
    coordinator = ListViewCoordinator(results: results)
    coordinator.goToMainView()
  }
}
