import Foundation
import UIKit
import SwiftUI
import Combine

struct MainPageView: View {
  @State private var name = ""
  let width = UIScreen.main.bounds.width
  let height = UIScreen.main.bounds.height
  @State var isModal = true
  @State var newResult = NewResult(resultCount: 0, results: Array<Res>())
  @State private var subscriptions = [AnyCancellable]()
  @State private var results = Results()
  let viewModel = MainPageViewModel()
  
  var body: some View {
    NavigationView {
      VStack {
        Spacer()
          .frame(width: width, height: 0.1 * height, alignment: .center)
        Text("Welcome, Burak")
          .font(.largeTitle)
          .frame(width: width, height: 0.2 * height, alignment: .center)
        Spacer()
          .frame(width: width, height: 0.15 * height, alignment: .center)
        VStack {
          TextField("Search Movie", text: $name)
            .multilineTextAlignment(.center)
            .font(.largeTitle)
          Spacer()
          Button("Search") {
            self.network(name: self.name)
            self.model()
            self.viewModel.goToListView(results: self.results)
          }
          .font(.title)
          Spacer()
          Spacer()
          Button("Advanced Search") {
            self.viewModel.goToAdvanced()
          }
          .font(.body)
          Spacer()
          Spacer()
          Button("Options") {
            self.viewModel.goToOptions()
          }
          .font(.subheadline)
          Spacer()
        }
        .frame(width: width, height: 0.3 * height, alignment: .center)
        Spacer()
          .frame(width: width, height: 0.25 * height, alignment: .center)
      }
    }
    .background(Color.primary)
  }
  
  func network(name: String) {
    NetworkManagement().getResults(name: name).receive(on: NetworkManagement().queue)
      .sink(receiveCompletion: {
        print($0)
      }) { print($0)
        self.newResult = $0 }
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
        let artworkUrl30 = arr[i].artworkUrl30
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

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainPageView()
  }
}

