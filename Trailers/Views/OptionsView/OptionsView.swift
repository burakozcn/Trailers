import SwiftUI

struct OptionsView: View {
  @State private var country = ""
  @State private var explicit = true
  @State private var number = 50
  @State private var array = ["Yes", "No"]
  @State private var selectionIndex = 0
  @State private var explicitName: String? = "Explicit"
  
  var body: some View {
    NavigationView {
      VStack {
        Spacer()
        HStack {
          Spacer()
          Text("Country")
          Spacer()
          TextField("Default is US", text: $country)
          Spacer()
        }
        HStack {
          Text("Explicit")
          TextFieldWithPickerAsInputView(data: array, placeHolder: "Choose One", selectionIndex: $selectionIndex, text: $explicitName)
        }
        HStack {
          Text("Number of Search")
          TextField("50", value: $number, formatter: NumberFormatter())
        }
        HStack {
          Text("Type")
          TextFieldWithPickerAsInputView(data: array, placeHolder: "Choose One", selectionIndex: $selectionIndex, text: $explicitName)
        }
        Spacer()
      }
    }
  }
}

struct OptionsView_Previews: PreviewProvider {
  static var previews: some View {
    OptionsView()
  }
}
