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
    if results.results.count != 0 {
      resultCache["results"] = results
    }
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
      for i in 0..<results.results.count {
        let resultModels = NSEntityDescription.insertNewObject(forEntityName: "ResultModel", into: context) as! ResultModel
        
        let users = try context.fetch(fetchRequest) as! [User]
        if checkResults(user: users.first!, trackName: results.results[i].trackName) {
          
          resultModels.artistName = results.results[i].artistName
          resultModels.collectionName = results.results[i].collectionName
          resultModels.country = results.results[i].country
          resultModels.previewUrl = results.results[i].previewUrl
          resultModels.artworkUrl30 = results.results[i].artworkUrl30
          resultModels.primaryGenreName = results.results[i].primaryGenreName
          resultModels.releaseDate = results.results[i].releaseDate
          resultModels.trackName = results.results[i].trackName
          
          users.first!.addToResults(resultModels)
          persistence.saveContext()
        }
      }
    } catch {
      print("There is a problem!!")
    }
  }
  
  
  private func checkResults(user: User, trackName: String) -> Bool {
    var a = true
    if let results = user.results {
      for result in results {
        if trackName == (result as! ResultModel).trackName {
          a = false
        }
      }
    }
    return a
  }
  
  func goToMainView() {
    coordinator = ListViewCoordinator(results: results)
    coordinator.goToMainView()
  }
  
  func goToDetail(result: Result) {
    coordinator = ListViewCoordinator(results: results)
    coordinator.goToDetailView(detailResult: result)
  }
}
