import Foundation
import UIKit
import SwiftUI
import Combine

struct MainPageView: View {
  let width = UIScreen.main.bounds.width
  let height = UIScreen.main.bounds.height
  let viewModel = MainPageViewModel()
  
  var body: some View {
    NavigationView {
      VStack {
        Spacer()
          .frame(width: width, height: 0.1 * height, alignment: .center)
        Text("Welcome, \(viewModel.username)")
          .font(.largeTitle)
          .frame(width: width, height: 0.2 * height, alignment: .center)
        Spacer()
          .frame(width: width, height: 0.12 * height, alignment: .center)
        VStack {
          TextField("Search Movie", text: Binding<String>(get: { self.viewModel.name }, set: { self.viewModel.name = $0 }))
            .multilineTextAlignment(.center)
            .font(.largeTitle)
          Spacer()
          Button("Search") {
            self.viewModel.network(name: self.viewModel.name)
            self.viewModel.model()
            self.viewModel.goToListView(results: self.viewModel.results)
          }
          .font(.title)
          Spacer()
          Button("Advanced Search") {
            self.viewModel.goToAdvanced()
          }
          .font(.body)
          Spacer()
          Button("Options") {
            self.viewModel.goToOptions()
          }
          .font(.subheadline)
          Spacer()
          Button("Saved Searches") {
            self.viewModel.bringSavedSearches()
          }
          .font(.subheadline)
          Spacer()
        }
        .frame(width: width, height: 0.4 * height, alignment: .center)
        Spacer()
          .frame(width: width, height: 0.17 * height, alignment: .center)
      }
    }
    .background(Color.primary)
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainPageView()
  }
}

