import UIKit
import CoreData
import SwiftUI
import Combine

class MasterViewModel {
  var masterCoordinator: MasterViewCoordinator!
  var persistence: Persistence!
  var subscriptions = [AnyCancellable]()
  var newResult = NewResult(resultCount: 0, results: Array<Res>())
  private var results = Results()
  
  func startView(window: UIWindow?, context: NSManagedObjectContext, x: PageSelection) {
        let contentView = MasterView(x: x).environment(\.managedObjectContext, context)
    
    window?.rootViewController = UIHostingController(rootView: contentView.environment(\.managedObjectContext
      , context))
  }
  
  func goToMain() {
    let window = UIApplication.shared.windows.first
    persistence = Persistence()
    let context = persistence.persistentContainer.viewContext
    
    startView(window: window, context: context, x: .main)
  }
  
  func network() {
    NetworkManagement().getResults(name: "").receive(on: NetworkManagement().queue)
      .sink(receiveCompletion: {
        print($0)
      }) { self.newResult = $0 }
      .store(in: &self.subscriptions)
  }
  
  func model() {
    delayWithSeconds(2) {
      let arr = self.newResult.results
      for i in 0..<self.newResult.resultCount {
        let artistName = arr[i].artistName
        let collectionName = arr[i].collectionName
        let country = arr[i].country
        let previewUrl = arr[i].previewUrl
        let primaryGenreName = arr[i].primaryGenreName
        let releaseDate = arr[i].releaseDate
        let artworkUrl30 = arr[i].artworkUrl100
        let trackName = arr[i].trackName
        let result = Result(artistName: artistName, collectionName: collectionName, country: country, previewUrl: previewUrl, primaryGenreName: primaryGenreName, releaseDate: releaseDate, artworkUrl30: artworkUrl30, trackName: trackName)
        self.results.results.append(result)
      }
    }
  }
  
  func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
      completion()
    }
  }
}
