//
//  ViewController.swift
//  Clima
//
//  Created by Ildar Garifullin on 07/02/2023.
//

import UIKit

final class ViewController: UIViewController {
    
    //MARK: - let/var
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let messagerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(messagerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 0, width: 300, height: 40))
        textField.placeholder = "Search"
        textField.backgroundColor = .clear
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 4
        textField.textColor = .black
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    var stackView = UIStackView()
    
    //MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    //MARK: - flow funcs
    @objc private func messagerButtonTapped() {
        print("messagerButtonTapped")
    }
    
    @objc private func searchButtonTapped() {
        print("messagerButtonTapped")
    }
    
    //MARK: - public
}

//MARK: - extension
extension ViewController {
    private func setupViews() {
        view.addSubview(backgroundImageView)
        
        stackView = UIStackView(
            arrangedSubviews: [
                messagerButton,
                searchTextField,
                searchButton
                
            ],
            axis: .horizontal,
            spacing: 5
        )
        
        view.addSubview(stackView)
    }
}

extension ViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
}
