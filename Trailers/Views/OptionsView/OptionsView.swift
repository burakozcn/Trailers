import SwiftUI

struct OptionsView: View {
  @State private var country = ""
  @State private var explicit = true
  @State private var array = ["Yes", "No"]
  @State private var typeArray = ["movie", "shortFilm", "tvShow"]
  @State private var numberArray = Array<Int>(stride(from: 0, to: 251, by: 5))
  @State private var selectionIndex = 0
  @State private var explicitName1: String? = "Explicit"
  @State private var explicitName2: String? = "Explicit"
  @State private var number: String? = "0"
  @EnvironmentObject var textModel: TextModel
  
  let width = UIScreen.main.bounds.width
  let height = UIScreen.main.bounds.height
  
  var body: some View {
    NavigationView {
      VStack {
        Spacer()
          .frame(width: width, height: height * 0.15, alignment: .center)
        Text("Options")
          .font(.largeTitle)
        HStack {
          Spacer()
          Text("Country")
            .frame(width: width * 0.4, height: height * 0.1, alignment: .center)
          Spacer()
          TextField("Default is US", text: $country)
            .frame(width: width * 0.55, height: height * 0.1, alignment: .center)
          Spacer()
        }
        HStack {
          Text("Explicit")
            .frame(width: width * 0.4, height: height * 0.1, alignment: .center)
          TextFieldWithPickerAsInputView(data: array, placeHolder: "Choose One", selectionIndex: $selectionIndex, text: $explicitName1)
            .frame(width: width * 0.55, height: height * 0.1, alignment: .center)
        }
        VStack {
          HStack {
            Text("Number of Search")
              .frame(width: width * 0.4, height: height * 0.1, alignment: .center)
            TextFieldWithPickerAsInputView(data: (numberArray.map { String($0) }), placeHolder: "Choose", selectionIndex: $selectionIndex, text: $number)
              .frame(width: width * 0.55, height: height * 0.1, alignment: .center)
          }
          Text("Please enter value between 0 to 200")
            .font(.caption)
        }
        HStack {
          Text("Type")
            .frame(width: width * 0.4, height: height * 0.1, alignment: .center)
          TextFieldWithPickerAsInputView(data: typeArray, placeHolder: "Choose One", selectionIndex: $selectionIndex, text: $explicitName2)
            .frame(width: width * 0.55, height: height * 0.1, alignment: .center)
        }
        Spacer()
          .frame(width: width, height: height * 0.25, alignment: .center)
      }
    }
  }
}

struct OptionsView_Previews: PreviewProvider {
  static var previews: some View {
    OptionsView().environmentObject(TextModel())
  }
}
