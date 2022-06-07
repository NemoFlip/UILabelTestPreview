//
//  UITextFieldViewController.swift
//  UILabelTestPreview
//
//  Created by Артем Хлопцев on 06.06.2022.
//

import UIKit

class UITextFieldViewController: UIViewController, UITextFieldDelegate {
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let nickNameTextField = UITextField()
    let logInButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TextField"
        // MARK: View settings
        let tabBarItem = UITabBarItem(title: "UITextField", image: UIImage(systemName: "textformat.abc"), selectedImage: nil)
        self.tabBarController?.tabBar.tintColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        self.tabBarItem = tabBarItem
        
        // MARK: SubViews
        createTextField(textField: emailTextField, placeHolder: "email", yOffset: 0, isSecure: false, textFieldType: .emailAddress)
        createTextField(textField: passwordTextField, placeHolder: "password", yOffset: 80, isSecure: true, textFieldType: .default)
        createTextField(textField: nickNameTextField, placeHolder: "nickname", yOffset: 160, isSecure: false, textFieldType: .default)
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { notification in
            self.view.frame.origin.y = -100
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { notification in
            self.view.frame.origin.y = 0
        }
        logInButton.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 150, height: 60)
        logInButton.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 150)
        logInButton.tintColor = .white
        logInButton.backgroundColor = .orange
        logInButton.layer.borderColor = UIColor.white.cgColor
        logInButton.layer.borderWidth = 1.5
        logInButton.layer.masksToBounds = true
        logInButton.configuration = .borderless()
        logInButton.layer.cornerRadius = 25
        logInButton.setTitle("Next", for: .normal)
        logInButton.addTarget(self, action: #selector(showNextScreen), for: .touchUpInside)
        self.view.addSubview(logInButton)
        self.view.backgroundColor = .brown
    }
    
    func createTextField(textField: UITextField, placeHolder: String, yOffset: CGFloat, isSecure: Bool, textFieldType: UIKeyboardType) {
        textField.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 50, height: 60)
        textField.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 150 + yOffset)
        textField.placeholder = "Type \(placeHolder)..."
        textField.textColor = .white
        textField.keyboardType = textFieldType
        textField.isSecureTextEntry = isSecure
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 20
        
        textField.delegate = self
        self.view.addSubview(textField)
    }
    @objc func showNextScreen() {
        if !(emailTextField.text?.isEmpty ?? true) && !(passwordTextField.text?.isEmpty ?? true) && !(nickNameTextField.text?.isEmpty ?? true) {
            let nextVC = ModalViewController()
            self.present(nextVC, animated: true, completion: nil)
        }
    }
    // MARK: TextField functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case textField where textField == emailTextField: passwordTextField.becomeFirstResponder()
        case textField where textField == passwordTextField: nickNameTextField.becomeFirstResponder()
        case textField where textField == nickNameTextField: nickNameTextField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}
