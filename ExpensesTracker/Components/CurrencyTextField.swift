//
//  CurrencyTextField.swift
//  ExpensesTracker
//
//  Created by Bernardo Santiago Marin on 18/11/24.
//

import SwiftUI
import UIKit

public struct CurrencyTextField: UIViewRepresentable {
    @Binding var value: Double
    private var isRespoder: Binding<Bool>?
    private var tag: Int
    private var alwaysShowDecimals: Bool
    private var numberOfDecimals: Int
    private var currencySymbol: String?
    
    private var placeholder: String
    
    private var contentType: UITextContentType?
    
    private var keyboardType: UIKeyboardType
    private var returnKeyType: UIReturnKeyType
    
    private var onReturn: () -> Void
    private var onEditingChanged: (Bool) -> Void
    
    @Environment(\.layoutDirection) private var layoutDirection
    @Environment(\.font) private var font
    
    init(
        _ placeholder: String = "",
        value: Binding<Double>,
        isRespoder: Binding<Bool>? = nil,
        tag: Int = 0,
        alwaysShowDecimals: Bool = false,
        numberOfDecimals: Int = 2,
        currencySymbol: String? = nil,
        contentType: UITextContentType? = nil,
        keyboardType: UIKeyboardType = .numberPad,
        returnKeyType: UIReturnKeyType = .default,
        onReturn: @escaping () -> Void = {},
        onEditingChanged: @escaping (Bool) -> Void = { _ in }
    ) {
        self._value = value
        self.isRespoder = isRespoder
        self.tag = tag
        self.alwaysShowDecimals = alwaysShowDecimals
        self.numberOfDecimals = numberOfDecimals
        self.currencySymbol = currencySymbol
        self.placeholder = placeholder
        self.contentType = contentType
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.onReturn = onReturn
        self.onEditingChanged = onEditingChanged
    }
    
    
    public func makeUIView(context: UIViewRepresentableContext<CurrencyTextField>) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        
        textField.addTarget(context.coordinator, action: #selector (context.coordinator.textFieldEditingDidBegin), for: .editingDidBegin)
        textField.addTarget(context.coordinator, action: #selector (context.coordinator.textFieldEditingDidEnd), for: .editingDidEnd)
        
        // initial value
        textField.text = value.currencyFormat(decimalPlaces: self.numberOfDecimals, forceShowDecimalPlaces: self.alwaysShowDecimals, currencySymbol: self.currencySymbol)
        
        textField.tag = self.tag
        
        // font
        textField.font = .preferredFont(forTextStyle: .body)
        
        switch context.environment.multilineTextAlignment {
            case .center:
            textField.textAlignment = .center
        case .leading:
            textField.textAlignment = .left
        case .trailing:
            textField.textAlignment = .right
        }
        
        textField.textColor = .label
        textField.placeholder = NSLocalizedString(placeholder, comment: "")
        textField.textContentType = contentType
        textField.tintColor = .accent
        textField.font = .preferredFont(forTextStyle: .body)
        textField.adjustsFontForContentSizeCategory = true
        
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        textField.clearButtonMode = .whileEditing
        
        textField.clearsOnBeginEditing = false
        textField.isSecureTextEntry = false
        textField.isUserInteractionEnabled = true
        
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return textField
    }
    
    public func updateUIView(_ textField: UITextField, context: UIViewRepresentableContext<CurrencyTextField>) {
        
        if self.value != context.coordinator.internalValue {
            textField.text = self.value.currencyFormat(decimalPlaces: self.numberOfDecimals, forceShowDecimalPlaces: self.alwaysShowDecimals, currencySymbol: self.currencySymbol)
        }
        
        // set first responder once
        if self.isRespoder?.wrappedValue == true && !textField.isFirstResponder && !context.coordinator.didBecomeFirstResponder {
            textField.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(value: $value,
                    isResponder: self.isRespoder,
                    alwasShowDecimals: self.alwaysShowDecimals,
                    numberOfDecimals: self.numberOfDecimals,
                    currencySymbol: self.currencySymbol,
                    onReturn: self.onReturn) { flag in
            self.onEditingChanged(flag)
        }
    }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var value: Double
        private var isResponder: Binding<Bool>?
        private var onReturn: () -> ()
        private var alwasShowDecimals: Bool
        private var numberOfDecimals: Int
        private var currencySymbol: String?
        
        var internalValue: Double
        var onEditingChanged: (Bool) -> ()
        var didBecomeFirstResponder = false
        
        init(value: Binding<Double>, isResponder: Binding<Bool>? = nil,
             alwasShowDecimals: Bool, numberOfDecimals: Int,
             currencySymbol: String? = nil,
             onReturn: @escaping () -> Void = {},
             onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
            self._value = value
            self.internalValue = value.wrappedValue
            self.isResponder = isResponder
            self.onReturn = onReturn
            self.alwasShowDecimals = alwasShowDecimals
            self.numberOfDecimals = numberOfDecimals
            self.currencySymbol = currencySymbol
            self.onEditingChanged = onEditingChanged
        }
        
        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // get new value
            let originalText = textField.text
            let text = textField.text as NSString?
            let newValue = text?.replacingCharacters(in: range, with: string)
            let display = newValue?.currencyFormat(decimalPlaces: self.numberOfDecimals, currencySymbol: self.currencySymbol ?? "$")
            
            if self.shouldAllowChange(oldValue: textField.text ?? "", newValue: newValue ?? "") == false {
                return false
            }
            
            self.value = newValue?.double ?? 0
            self.internalValue = self.value
            
            // Prevent cursor from moving if nothing changed
            if originalText == display && string.count > 0 {
                return false
            }
            
            // Update text field display
            textField.text = display
            
            // calculate and update cursor position
            // update cursor position
            let beginningPosition = textField.beginningOfDocument
            
            var numberOfCharactersAfterCursor: Int
            if string.count == 0 && originalText == display {
                // if deleting and nothing changed, use lower bound of range
                // to allow cursor to move backwards
                numberOfCharactersAfterCursor = (originalText?.count ?? 0) - range.lowerBound
            } else {
                numberOfCharactersAfterCursor = (originalText?.count ?? 0) - range.upperBound
            }
            
            let offset = (display?.count ?? 0) - numberOfCharactersAfterCursor
            
            let cursorLocation = textField.position(from: beginningPosition, offset: offset)
            
            if let cursorLoc = cursorLocation {
                /**
                 Shortly after new text is being pasted from the clipboard, UITextField receives a new value for its
                 `selectedTextRange` property from the system. This new range is not consistent to the formatted text and
                 calculated caret position most of the time, yet it's being assigned just after setCaretPosition call.
                 
                 To insure correct caret position is set, `selectedTextRange` is assigned asynchronously.
                 (presumably after a vanishingly small delay)
                 */
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                    textField.selectedTextRange = textField.textRange(from: cursorLoc, to: cursorLoc)
                }
            }
            return false
        }
        
        private func shouldAllowChange(oldValue: String, newValue: String) -> Bool {
            // Disallow if already has decimals
            if newValue.numberOfDecimalPoints > 1 { return false }
            
            // Limit integer count
            if newValue.integers.count > 10 { return false }
            
            // Limit fraction length
            if newValue.fractions?.count ?? 0 > self.numberOfDecimals { return false }
            
            return true
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.isResponder?.wrappedValue = true
            }
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            textField.text = self.value.currencyFormat(decimalPlaces: self.numberOfDecimals, forceShowDecimalPlaces: self.alwasShowDecimals, currencySymbol: self.currencySymbol)
            DispatchQueue.main.async {
                self.isResponder?.wrappedValue = false
            }
        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                nextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
            
            self.onReturn()
            return true
        }
        
        @objc func textFieldEditingDidBegin(_ textField: UITextField) {
            onEditingChanged(true)
        }
        
        @objc func textFieldEditingDidEnd(_ textField: UITextField) {
            onEditingChanged(false)
        }
        
    }
}


// Useful string functions to format as Currency
fileprivate extension String {
    var numberOfDecimalPoints: Int {
        let separatedByDecimal = components(separatedBy: Locale.current.decimalSeparator ?? ".")
        return separatedByDecimal.count - 1 // "1.5" -> [1, 5] Just one decimal separator
    }
    
    // all numbers with decimals
    var decimals: String {
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        let characters = CharacterSet(charactersIn: "0123456789" + decimalSeparator)
        return components(separatedBy: characters.inverted).joined()
    }
    
    // just numbers
    var numbers: String {
        let numberCharacters = CharacterSet(charactersIn: "0123456789")
        return components(separatedBy: numberCharacters.inverted).joined()
    }
    
    var integers: String {
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        return decimals.components(separatedBy: decimalSeparator).first ?? ""
    }
    
    var fractions: String? {
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        let split = decimals.components(separatedBy: decimalSeparator)
        if split.count > 1 {
            return split.last ?? ""
        } else {
            return nil
        }
    }
    
    var double: Double? {
        var d = decimals
        if d.count == 0 {
            return nil
        }
        d = d.replacingOccurrences(of: ",", with: ".")
        return Double(d) ?? 0
    }
    
    func currencyFormat(decimalPlaces: Int = 2, currencySymbol: String = "") -> String? {
        guard let double = self.double else { return nil }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        
        if let fractions {
            let fractionDigits = fractions.count
            
            // Show whatever is less between the fraction digits in the string
            // or the allowed decimal places
            formatter.minimumFractionDigits = min(fractionDigits, decimalPlaces)
            formatter.maximumFractionDigits = min(fractionDigits, decimalPlaces)
            
            let formatted = formatter.string(from: NSNumber(value: double))
            if let formatted, fractionDigits == 0 {
                return formatted + decimalSeparator
            }
            
            return formatted
        }
        
        formatter.currencySymbol = currencySymbol
        formatter.maximumFractionDigits = 0
        let formatted = formatter.string(from: NSNumber(value: double))
        return formatted
    }
    
}

extension Double {
    func currencyFormat(decimalPlaces: Int = 2, forceShowDecimalPlaces: Bool = false, currencySymbol: String? = nil) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        var integer = 0.0
        
        if forceShowDecimalPlaces {
            formatter.minimumFractionDigits = decimalPlaces
            formatter.maximumFractionDigits = decimalPlaces
        } else {
            let fraction = modf(self, &integer) // https://stackoverflow.com/questions/24996994/swift-get-fraction-of-float
            if fraction > 0 {
                formatter.maximumFractionDigits = decimalPlaces
            } else {
                formatter.maximumFractionDigits = 0
            }
        }
        
        if currencySymbol != nil {
            formatter.currencyCode = currencySymbol
        }
        
        return formatter.string(from: NSNumber(value: self))
    }
}
