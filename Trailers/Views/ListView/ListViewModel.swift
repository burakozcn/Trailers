import Foundation
import SwiftUI

class ListViewModel {
  private let network = NetworkManagement()
  private var listView: ListView!
  private var coordinator: ListViewCoordinator!
  let results: Results
  
  init(results: Results) {
    self.results = results
    ListView().environmentObject(results)
  }
  
  func goToMainView() {
    coordinator = ListViewCoordinator(results: results)
    coordinator.goToMainView()
  }
}
