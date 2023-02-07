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
    
    
    //MARK: - life cycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    //MARK: - flow funcs
    private func setupViews() {
        view.addSubview(backgroundImageView)
    }
    
    //MARK: - public
}

//MARK: - extension
extension ViewController {
    private func setConstraints() {
    }
}
