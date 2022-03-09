//
//  ViewController.swift
//  MyWordle
//
//  Created by Administrator on 09.03.2022.
//

import UIKit

class ViewController: UIViewController {

    let keyboardVC = KeyboardViewController()
    let boardVC = BoardViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        addChildren()
    }

    private func addChildren() {
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        view.addSubview(keyboardVC.view)
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        view.addSubview(boardVC.view)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     boardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
                                     boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
                                    
                                     keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
}

