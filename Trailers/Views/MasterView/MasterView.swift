import SwiftUI

struct MasterView: View {
  @State private var name = ""
  let width = UIScreen.main.bounds.width
  let height = UIScreen.main.bounds.height
  @State private var close = true
  @State private var menuName = "Menu"
  
  var body: some View {
    NavigationView {
      HStack {
        SideBarMenuView()
          .frame(width: width * 0.8, height: height, alignment: .center)
        MainView()
          .frame(width: width, height: height, alignment: .trailing)
      }
      .offset(x: close ? -width * 0.42 : width * 0.33, y: 0)
      .navigationBarItems(leading: Button(menuName) {
        if self.close {
          self.close = false
          self.menuName = "Close"
        } else {
          self.close = true
          self.menuName = "Menu"
        }
      })
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MasterView()
  }
}
