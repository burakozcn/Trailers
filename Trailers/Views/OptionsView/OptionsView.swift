import SwiftUI

struct OptionsView: View {
  @State var appear = false
  
  var body: some View {
    NavigationView {
      Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        .navigationBarItems(leading: NavigationLink("Back", destination: MainView()))
    }
    .onAppear() {
      self.appear = true
      print("Options Appear")
    }
  }
}

struct OptionsView_Previews: PreviewProvider {
  static var previews: some View {
    OptionsView()
  }
}
