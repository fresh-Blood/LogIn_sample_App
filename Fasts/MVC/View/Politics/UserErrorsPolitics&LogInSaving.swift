import Foundation
import UIKit


final class UserErrorsPolitics {
    static func checkUser(_ mailTxt: UITextField, _ passTxt: UITextField, _ email: String, _ passWord: String) -> Bool {
        var result: Bool
        
        if email.isEmpty {
            mailTxt.text = "Please, enter your e-mail"
            result = false
        } else if !email.contains("@") || !email.contains(".") || email.contains(" ") {
            mailTxt.text = "Errors, please try again"
            result = false
        } else if ((email.components(separatedBy: "@").count - 1) != 1) || ((email.components(separatedBy: ".").count - 1) != 1) && ((email.components(separatedBy: " ").count - 1) != 0) {
            mailTxt.text = "Errors, please try again"
            result = false
        } else {
            result = true
        }
        
        if passWord.isEmpty {
            passTxt.text = "Please, enter your password"
            passTxt.isSecureTextEntry = false
            result = false
        } else if passWord.count < 8 {
            passTxt.text = "Password minimum length = 8"
            passTxt.isSecureTextEntry = false
            result = false
        } else if !email.contains("@") || !email.contains(".") || email.contains(" ") {
            passTxt.text = "Errors, please try again"
            passTxt.isSecureTextEntry = false
            result = false
        } else if ((email.components(separatedBy: " ").count - 1) != 0) {
            passTxt.text = "Errors, please try again"
            passTxt.isSecureTextEntry = false
            result = false
        } else {
            result = true
            passTxt.isSecureTextEntry = true
        }
        
        if UserDefaults.standard.object(forKey: email) == nil {
            result = false
            mailTxt.text = "This login is not registered"
        } else {
            result = true
        }
        if UserDefaults.standard.object(forKey: passWord) == nil {
            result = false
            passTxt.text = "Invalid password, please try again"
        } else {
            result = true
        }
        
        return result
    }
    
    static func checkUserSign(_ mailTxt: UITextField, _ passTxt: UITextField, _ email: String, _ passWord: String) -> Bool {
        var result: Bool
        
        if email.isEmpty {
            mailTxt.text = "Please, enter your e-mail"
            result = false
        } else if !email.contains("@") || !email.contains(".") || email.contains(" ") {
            mailTxt.text = "Errors, please try again"
            result = false
        } else if ((email.components(separatedBy: "@").count - 1) != 1) || ((email.components(separatedBy: ".").count - 1) != 1) && ((email.components(separatedBy: " ").count - 1) != 0) {
            mailTxt.text = "Errors, please try again"
            result = false
        } else {
            result = true
        }
        
        if passWord.isEmpty {
            passTxt.text = "Please, enter your password"
            passTxt.isSecureTextEntry = false
            result = false
        } else if passWord.count < 8 {
            passTxt.text = "Password minimum length = 8"
            passTxt.isSecureTextEntry = false
            result = false
        } else if !email.contains("@") || !email.contains(".") || email.contains(" ") {
            passTxt.text = "Errors, please try again"
            passTxt.isSecureTextEntry = false
            result = false
        } else if ((email.components(separatedBy: " ").count - 1) != 0) {
            passTxt.text = "Errors, please try again"
            passTxt.isSecureTextEntry = false
            result = false
        } else {
            result = true
            passTxt.isSecureTextEntry = true
        }
        
        if UserDefaults.standard.object(forKey: email) == nil {
            result = true
            UserDefaults.standard.set(email, forKey: "\(email.description)")
            UserDefaults.standard.set(passWord, forKey: "\(passWord.description)")
        } else {
            result = false
            mailTxt.text = "This login is already registered"
        }
        return result
    }
}
