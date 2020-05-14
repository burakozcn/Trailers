import Foundation
import CoreData
import Combine

class MainPageViewModel: ObservableObject {
  @Published var name = ""
  @Published var newResult = NewResult(resultCount: 0, results: Array<Res>())
  @Published var results = Results()
  private var subscriptions = [AnyCancellable]()
  
  var mainPageViewCoordinator: MainPageViewCoordinator!
  var persistence: Persistence!
  var username: String = Helper().user.name
  
  func goToOptions() {
    mainPageViewCoordinator = MainPageViewCoordinator()
    mainPageViewCoordinator.goToOptions()
  }
  
  func goToAdvanced() {
    mainPageViewCoordinator = MainPageViewCoordinator()
    mainPageViewCoordinator.goToAdvanced()
  }
  
  func goToListView(results: Results) {
    mainPageViewCoordinator = MainPageViewCoordinator()
    mainPageViewCoordinator.goToListView(results: results)
  }
  
  func bringSavedSearches() {
    persistence = Persistence()
    let context = persistence.persistentContainer.viewContext
    
    let predicate = NSPredicate(format: "name = '\(username)'")
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    fetchRequest.predicate = predicate
    
    do {
      let users = try context.fetch(fetchRequest) as! [User]
      model(resultModel: users.first!.results!.allObjects as! [ResultModel])
      goToListView(results: results)
    } catch {
      print("")
    }
  }
  
  func network(name: String) {
    let sem = DispatchSemaphore(value: 0)
    
    NetworkManagement().getResults(name: name).receive(on: NetworkManagement().queue)
      .sink(receiveCompletion: {
        print($0)
      }) { self.newResult = $0
        sem.signal()
    }
    .store(in: &self.subscriptions)
    sem.wait()
  }
  
  func model() {
    let arr = self.newResult.results
    for i in 0..<self.newResult.resultCount {
      let artistName = arr[i].artistName
      let collectionName = arr[i].collectionName
      let country = arr[i].country
      let previewUrl = arr[i].previewUrl
      let primaryGenreName = arr[i].primaryGenreName
      let releaseDate = arr[i].releaseDate
      let artworkUrl30 = arr[i].artworkUrl30
      let trackName = arr[i].trackName
      let result = Result(artistName: artistName, collectionName: collectionName, country: country, previewUrl: previewUrl, primaryGenreName: primaryGenreName, releaseDate: releaseDate, artworkUrl30: artworkUrl30, trackName: trackName)
      self.results.results.append(result)
    }
  }
  
  func model(resultModel: [ResultModel]) {
    for i in 0..<resultModel.count {
      let artistName = resultModel[i].artistName
      let collectionName = resultModel[i].collectionName
      let country = resultModel[i].country
      let previewUrl = resultModel[i].previewUrl
      let primaryGenreName = resultModel[i].primaryGenreName
      let releaseDate = resultModel[i].releaseDate
      let artworkUrl30 = resultModel[i].artworkUrl30
      let trackName = resultModel[i].trackName
      let result = Result(artistName: artistName, collectionName: collectionName, country: country, previewUrl: previewUrl, primaryGenreName: primaryGenreName, releaseDate: releaseDate, artworkUrl30: artworkUrl30, trackName: trackName)
      self.results.results.append(result)
    }
  }
}
