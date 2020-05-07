import SwiftUI

struct LoginView: View {
  @State var viewModel: LoginViewModel!
  @State var name = ""
  let width = UIScreen.main.bounds.width
  let height = UIScreen.main.bounds.height
  
  var body: some View {
    VStack {
      Spacer()
        .frame(width: width * 0.9, height: height * 0.3, alignment: .center)
      Text("Please enter your name and surname")
        .font(.title)
        .multilineTextAlignment(.center)
        .frame(width: width * 0.9, height: height * 0.2, alignment: .center)
      TextField("Your name and surname", text: $name)
        .multilineTextAlignment(.center)
        .font(.title)
        .frame(width: width * 0.9, height: height * 0.1, alignment: .center)
      Text("If you have entered your name and surname before you login, otherwise you will sign up and login")
        .font(.headline)
        .multilineTextAlignment(.center)
        .frame(width: width * 0.9, height: height * 0.1, alignment: .center)
      Button("Login") {
        self.viewModel = LoginViewModel()
        self.viewModel.nameLogin(name: self.name)
      }
      .font(.title)
      .frame(width: width * 0.9, height: height * 0.1, alignment: .center)
      Spacer()
        .frame(width: width * 0.9, height: height * 0.2, alignment: .center)
    }
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
