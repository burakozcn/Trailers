import SwiftUI

struct OptionsView: View {
  let viewModel = OptionsViewModel()
  @EnvironmentObject var textModel: TextModel
  @State var explicitName1: String? = "Explicit"
  
  let width = UIScreen.main.bounds.width
  let height = UIScreen.main.bounds.height
  
  var body: some View {
    NavigationView {
      VStack {
        Spacer()
          .frame(width: width, height: height * 0.12, alignment: .center)
        Text("Options")
          .font(.largeTitle)
        HStack {
          Spacer()
          Text("Country")
            .frame(width: width * 0.4, height: height * 0.1, alignment: .center)
          Spacer()
          TextField("Default is US", text: Binding<String>(
            get: { self.viewModel.country },
            set: { self.viewModel.country = $0 }
          ))
            .frame(width: width * 0.55, height: height * 0.1, alignment: .center)
          Spacer()
        }
        HStack {
          Text("Explicit")
            .frame(width: width * 0.4, height: height * 0.1, alignment: .center)
          TextFieldWithPickerAsInputView(data: self.viewModel.array, placeHolder: "Choose One", selectionIndex: Binding<Int>(
            get: { self.viewModel.selectionIndex },
            set: { string in self.viewModel.selectionIndex = string }
            ), text: Binding<String>(get: { self.viewModel.explicitName1 }, set: {
              self.viewModel.explicitName1 = $0
            }))
            .frame(width: width * 0.55, height: height * 0.1, alignment: .center)
        }
        VStack {
          HStack {
            Text("Number of Search")
              .frame(width: width * 0.4, height: height * 0.1, alignment: .center)
            TextFieldWithPickerAsInputView(data: (self.viewModel.numberArray.map { String($0) }), placeHolder: "Choose", selectionIndex: Binding<Int>(
              get: { self.viewModel.selectionIndex },
              set: { self.viewModel.selectionIndex = $0 }
            ), text: Binding<String>(get: { self.viewModel.number }, set: { self.viewModel.number = $0 }))
              .frame(width: width * 0.55, height: height * 0.1, alignment: .center)
          }
          Text("Please enter value between 0 to 200")
            .font(.caption)
        }
        HStack {
          Text("Type")
            .frame(width: width * 0.4, height: height * 0.1, alignment: .center)
          TextFieldWithPickerAsInputView(data: self.viewModel.typeArray, placeHolder: "Choose One", selectionIndex: Binding<Int>(
            get: { self.viewModel.selectionIndex },
            set: { self.viewModel.selectionIndex = $0 }
            ), text: Binding<String>(get: { self.viewModel.explicitName2 }, set: {
              self.viewModel.explicitName2 = $0
            }))
            .frame(width: width * 0.55, height: height * 0.1, alignment: .center)
        }
        Button("Save") {
          self.viewModel.saveOptions()
        }
        .font(.title)
        .frame(width: width, height: height * 0.08, alignment: .center)
        Spacer()
          .frame(width: width, height: height * 0.20, alignment: .center)
      }
    }
  }
}

struct OptionsView_Previews: PreviewProvider {
  static var previews: some View {
    OptionsView().environmentObject(TextModel())
  }
}
