import SwiftUI

struct AdvancedSearchView: View {
  private var array = ["Genre", "Artist", "Producer", "Director", "Release Year", "Rating", "Description"]
  @State private var chosenArray: [String] = []
  @State private var searchCount = 0
  @State private var selectionIndex = 0
  @State private var field1 = ""
  @State private var search1 = ""
  @State private var field2 = ""
  @State private var search2 = ""
  @State private var field3 = ""
  @State private var search3 = ""
  @State private var field4 = ""
  @State private var search4 = ""
  @State private var field5 = ""
  @State private var search5 = ""
  
  let width = UIScreen.main.bounds.width
  let height = UIScreen.main.bounds.height
  
  var body: some View {
    NavigationView {
      VStack {
        Spacer()
          .frame(width: width, height: height * 0.2, alignment: .center)
        Text("Advanced Search")
          .font(.largeTitle)
        HStack {
          TextFieldWithPickerAsInputView(data: array.difference(from: chosenArray), placeHolder: "Field 1", selectionIndex: $selectionIndex, text: $field1)
            .frame(width: width * 0.4, height: height * 0.08, alignment: .center)
          TextField("Search 1", text: $search1)
            .frame(width: width * 0.55, height: height * 0.08, alignment: .center)
        }
        if searchCount > 0 {
          HStack {
            TextFieldWithPickerAsInputView(data: array.difference(from: chosenArray), placeHolder: "Field 2", selectionIndex: $selectionIndex, text: $field2)
              .frame(width: width * 0.4, height: height * 0.08, alignment: .center)
            TextField("Search 2", text: $search2)
              .frame(width: width * 0.55, height: height * 0.08, alignment: .center)
          }
        }
        if searchCount > 1 {
          HStack {
            TextFieldWithPickerAsInputView(data: array.difference(from: chosenArray), placeHolder: "Field 3", selectionIndex: $selectionIndex, text: $field3)
              .frame(width: width * 0.4, height: height * 0.08, alignment: .center)
            TextField("Search 3", text: $search3)
              .frame(width: width * 0.55, height: height * 0.08, alignment: .center)
          }
        }
        if searchCount > 2 {
          HStack {
            TextFieldWithPickerAsInputView(data: array.difference(from: chosenArray), placeHolder: "Field 4", selectionIndex: $selectionIndex, text: $field4)
              .frame(width: width * 0.4, height: height * 0.08, alignment: .center)
            TextField("Search 4", text: $search4)
              .frame(width: width * 0.55, height: height * 0.08, alignment: .center)
          }
        }
        if searchCount > 3 {
          HStack {
            TextFieldWithPickerAsInputView(data: array.difference(from: chosenArray), placeHolder: "Field 5", selectionIndex: $selectionIndex, text: $field5)
              .frame(width: width * 0.4, height: height * 0.08, alignment: .center)
            TextField("Search 5", text: $search2)
              .frame(width: width * 0.55, height: height * 0.08, alignment: .center)
          }
        }
        VStack {
          HStack {
            Button(action: {
              self.addToArray()
              if self.searchCount > -1 && self.searchCount < 4 && self.addCheck() {
                self.searchCount += 1
              }
            }) {
              Text("Add")
                .font(.title)
            }
            Button(action: {
              self.removeFromArray()
              if self.searchCount > 0 && self.searchCount < 5 {
                self.searchCount -= 1
              }
            }) {
              Text("Delete")
                .font(.title)
            }
          }
          Button(action: {
            
          }) {
            Text("Search")
              .font(.headline)
          }
        }
        Spacer()
          .frame(width: width, height: height * (0.6 - 0.08 * CGFloat((searchCount))), alignment: .center)
      }
    }
  }
  
  func addCheck() -> Bool {
    if searchCount == 0 && field1 != "" {
      return true
    } else if searchCount == 1 && field2 != "" {
      return true
    } else if searchCount == 2 && field3 != "" {
      return true
    } else if searchCount == 3 && field4 != "" {
      return true
    } else if searchCount == 4 && field5 != "" {
      return true
    } else {
      return false
    }
  }
  
  func addToArray() {
    if searchCount == 0 && field1 != "" {
      chosenArray.append(field1)
    } else if searchCount == 1 && field2 != "" {
      chosenArray.append(field2)
    } else if searchCount == 2 && field3 != "" {
      chosenArray.append(field3)
    } else if searchCount == 3 && field4 != "" {
      chosenArray.append(field4)
    } else if searchCount == 4 && field5 != "" {
      chosenArray.append(field5)
    }
  }
  
  func removeFromArray() {
    if searchCount == 0 {
      if let index = chosenArray.firstIndex(of: field1) {
        chosenArray.remove(at: index)
      }
      field1 = ""
    } else if searchCount == 1 {
      if let index = chosenArray.firstIndex(of: field2) {
        chosenArray.remove(at: index)
      }
      field2 = ""
    } else if searchCount == 2 {
      if let index = chosenArray.firstIndex(of: field3) {
        chosenArray.remove(at: index)
      }
      field3 = ""
    } else if searchCount == 3 {
      if let index = chosenArray.firstIndex(of: field4) {
        chosenArray.remove(at: index)
      }
      field4 = ""
    } else if searchCount == 4 {
      if let index = chosenArray.firstIndex(of: field5) {
        chosenArray.remove(at: index)
      }
      field5 = ""
    }
  }
}

struct AdvancedSearchView_Previews: PreviewProvider {
  static var previews: some View {
    AdvancedSearchView()
  }
}
