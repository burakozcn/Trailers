import UIKit
import SwiftUI

struct TextFieldWithPickerAsInputView: UIViewRepresentable {
  
  var data: [String]
  var placeHolder: String
  
  @Binding var selectionIndex: Int
  @Binding var text: String
  
  private let textField = UITextField()
  private let picker = UIPickerView()
  
  func makeCoordinator() -> TextFieldWithPickerAsInputView.Coordinator {
    Coordinator(textField: self)
  }
  
  func makeUIView(context: Context) -> UITextField {
    picker.delegate = context.coordinator
    picker.dataSource = context.coordinator
    picker.tintColor = .black
    textField.placeholder = placeHolder
    textField.inputView = picker
    textField.inputAccessoryView = context.coordinator.toolbarSetup()
    textField.delegate = context.coordinator as UITextFieldDelegate
    return textField
  }
  
  func updateUIView(_ uiView: UITextField, context: Context) {
    uiView.text = text
  }
    
  class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    private let parent: TextFieldWithPickerAsInputView
    
    init(textField: TextFieldWithPickerAsInputView) {
      self.parent = textField
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return self.parent.data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return self.parent.data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      self.parent.$selectionIndex.wrappedValue = row
      self.parent.textField.text = self.parent.data[row]
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      self.parent.textField.resignFirstResponder()
    }
    
    func toolbarSetup() -> UIToolbar {
      let toolbar = UIToolbar()
      toolbar.sizeToFit()
      let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
      let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
      let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker))

      toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
      return toolbar
    }

    @objc func donePicker() {
      self.parent.text = self.parent.textField.text!
      self.parent.textField.endEditing(true)
    }

    @objc func cancelPicker() {
      self.parent.textField.text = ""
      self.parent.textField.endEditing(true)
    }
  }
  
}
