//
//  ViewController.swift
//  Clima
//
//  Created by Ildar Garifullin on 07/02/2023.
//

import UIKit

final class WeatherViewController: UIViewController, WeatherManagerDelegate {
    //MARK: - let/var
    var weatherManager = WeatherManager()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let messagerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        button.tintColor = UIColor(named: "weatherColor")
        button.addTarget(self, action: #selector(messagerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.setContentHuggingPriority(UILayoutPriority(247), for: .horizontal)
        textField.backgroundColor = .clear
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textAlignment = .right
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor(named: "weatherColor")?.cgColor
        textField.layer.cornerRadius = 4
        textField.textColor = UIColor(named: "weatherColor")
        textField.clearButtonMode = .always
        textField.returnKeyType = .go
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = UIColor(named: "weatherColor")
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    var stackView = UIStackView()
    
    private let conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        imageView.tintColor = UIColor(named: "weatherColor")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let temperatureValueLabel: UILabel = {
        let label = UILabel()
        label.text = "21"
        label.textColor = UIColor(named: "weatherColor")
        label.font = UIFont.boldSystemFont(ofSize: 80)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let unitTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "°C"
        label.textColor = UIColor(named: "weatherColor")
        label.font = label.font.withSize(80)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var temperatureStackView = UIStackView()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "London"
        label.textColor = UIColor(named: "weatherColor")
        label.font = label.font.withSize(30)
        
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
    //MARK: - flow funcs
    @objc private func messagerButtonTapped() {
        print("messagerButtonTapped")
    }
    
    @objc private func searchButtonTapped() {
        searchTextField.endEditing(true)
    }
    
    //MARK: - public
}

//MARK: - extension
extension WeatherViewController {
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

        view.addSubview(conditionImageView)
        
        temperatureStackView = UIStackView(
            arrangedSubviews: [
                temperatureValueLabel,
                unitTemperatureLabel
            ],
            axis: .horizontal,
            spacing: 2)
        view.addSubview(temperatureStackView)
        
        view.addSubview(cityLabel)
    }
}

extension WeatherViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            conditionImageView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            conditionImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            conditionImageView.widthAnchor.constraint(equalToConstant: 120),
            conditionImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            temperatureStackView.topAnchor.constraint(equalTo: conditionImageView.bottomAnchor, constant: 10),
            temperatureStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            temperatureStackView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: temperatureStackView.bottomAnchor, constant: 10),
            cityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            cityLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        temperatureValueLabel.text = weather.temperatureString
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}
