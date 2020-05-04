import SwiftUI

struct MasterView: View {
  @State private var name = ""
  let width = UIScreen.main.bounds.width
  let height = UIScreen.main.bounds.height
  @State private var close = true
  @State private var menuName = "Menu"
  @State var x: PageSelection
  let viewModel = MasterViewModel()
  
  var body: some View {
    NavigationView {
      HStack {
        SideBarMenuView()
          .frame(width: width * 0.8, height: height, alignment: .center)
        if x.rawValue == 0 {
          MainPageView()
            .frame(width: width, height: height, alignment: .trailing)
        } else if x.rawValue == 1 {
          OptionsView()
          .environmentObject(TextModel())
            .frame(width: width, height: height, alignment: .trailing)
        } else if x.rawValue == 2 {
          AdvancedSearchView()
          .frame(width: width, height: height, alignment: .trailing)
        } else {
          Text("A problem has occured")
        }
      }
      .offset(x: close ? -width * 0.42 : width * 0.33, y: 0)
      .navigationBarItems(leading:
        HStack {
          if x.rawValue == 1 || x.rawValue == 2 && self.close {
            Button ("<") {
              self.viewModel.goToMain()
            }
          }
          Button(menuName) {
            if self.close {
              self.close = false
              self.menuName = "Close"
            } else {
              self.close = true
              self.menuName = "Menu"
            }
          }
      })
    }
  }
}
  
  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      MasterView(x: .main).environment(\.managedObjectContext, Persistence().persistentContainer.viewContext)
    }
}
