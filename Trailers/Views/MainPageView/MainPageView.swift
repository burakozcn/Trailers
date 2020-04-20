import UIKit
import SwiftUI
import Combine

struct MainPageView: View {
  @State private var name = ""
  let width = UIScreen.main.bounds.width
  let height = UIScreen.main.bounds.height
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
          Button("Search") { }
            .font(.headline)
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
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainPageView()
  }
}

