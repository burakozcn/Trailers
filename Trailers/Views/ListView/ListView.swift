import SwiftUI
import Combine

struct ListView: View {
  @EnvironmentObject var result: Results
  @State var viewModel: ListViewModel!
  
  var body: some View {
    NavigationView {
      return List(result.results) { result in
        ListRow(result: result)
      }
      .navigationBarTitle("Results")
      .navigationBarItems(leading: Button("< Back") {
        self.viewModel = ListViewModel(results: self.result)
        self.viewModel.goToMainView()
      })
    }
  }
}

struct ListView_Previews: PreviewProvider {
  static var previews: some View {
    ListView().environmentObject(Results())
  }
}


struct ListRow: View {
  var result: Result
  
  var body: some View {
    Text("\(result.trackName)")
  }
}
