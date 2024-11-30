//
//  ViewController.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 29.11.2024.
//

import UIKit

class LoginViewController: UIViewController {
    var presenter: LoginPresenterProtocol?
    
    let button = UIButton()
    
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    
    let usernameLabel = UILabel()
    let passwordLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        usernameLabel.text = "Username"
        passwordLabel.text = "Password"
        
        usernameTextField.placeholder = "Enter username"
        passwordTextField.placeholder = "Enter password"
        passwordTextField.isSecureTextEntry = true
        
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10

        view.addSubview(button)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(usernameLabel)
        view.addSubview(passwordLabel)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            passwordLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            button.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
    }
    
    @objc func loginButtonTapped() {
        if let username = usernameTextField.text, let password = passwordTextField.text {
            presenter?.login(username: username, password: password)
        } else {
            showError(message: "Please enter username and password")
        }
    }
}

extension LoginViewController: LoginViewProtocol {
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

