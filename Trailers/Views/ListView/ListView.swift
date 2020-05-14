import SwiftUI
import Combine

struct ListView: View {
  @EnvironmentObject var result: Results
  @State var viewModel: ListViewModel!
  
  var body: some View {
    NavigationView {
      VStack {
        List(result.results) { result in
          ListRow(result: result)
        }
        Button("Save Results") {
          self.viewModel = ListViewModel(results: self.result)
          self.viewModel.saveResults()
        }
        .navigationBarTitle("Results")
        .navigationBarItems(leading: Button("< Back") {
          self.viewModel = ListViewModel(results: self.result)
          self.viewModel.goToMainView()
        })
      }
    }
  }
}

struct ListView_Previews: PreviewProvider {
  static var previews: some View {
    ListView().environmentObject(Results())
  }
}


struct ListRow: View {
  @Environment(\.imageCache) var cache: ImageCache
  var result: Result
  let width = UIScreen.main.bounds.width
  let height = UIScreen.main.bounds.height
  
  var body: some View {
    HStack {
      AsyncImage(url: URL(string: result.artworkUrl30)!, placeholder: Text("Loading"), cache: self.cache)
        .frame(width: width / 12, height: height / 18, alignment: .center)
        .aspectRatio(contentMode: .fit)
      Text("\(result.trackName)")
    }
  }
}
