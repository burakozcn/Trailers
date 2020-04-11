import SwiftUI
import Combine

struct MainView: View {
  @State private var name = ""
  let width = UIScreen.main.bounds.width
  let height = UIScreen.main.bounds.height
  @State var going = false
  
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
          Button("Advanced Search") { }
            .font(.body)
          Spacer()
          Spacer()
          NavigationLink(destination: OptionsView()) {
            Text("Options")
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
    MainView()
  }
}

