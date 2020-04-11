import SwiftUI

struct SideBarMenuView: View {
  let width = UIScreen.main.bounds.width
  let height = UIScreen.main.bounds.height
  
  var body: some View {
    VStack {
      Spacer()
        .frame(width: width, height: height * 0.3, alignment: .center)
      VStack {
        Text("Hello, Burak")
          .font(.largeTitle)
        Spacer()
          .frame(width: width, height: height * 0.1, alignment: .center)
        Text("Your Options")
          .font(.headline)
        Spacer()
        Spacer()
        Text("This")
        Spacer()
        Text("That")
        Spacer()
        Spacer()
      }
      .offset(x: width * 0.08, y: 0)
      Spacer()
        .frame(width: width, height: height * 0.3, alignment: .center)
    }
    .background(Color.green)
  }
  
  struct SideBarMenuView_Previews: PreviewProvider {
    static var previews: some View {
      SideBarMenuView()
    }
  }
}
