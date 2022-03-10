//
//  ViewController.swift
//  MyWordle
//
//  Created by Administrator on 09.03.2022.
//

import UIKit
import random_swift

class ViewController: UIViewController {
    private var guesses: [[Character?]] = Array(repeating: Array(repeating: nil, count: 5), count: 6)
    var answer = "after"
    let keyboardVC = KeyboardViewController()
    let boardVC = BoardViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        addChildren()
        set5LetterWord() //set new answer of 5 letters
    }
    
    private func addChildren() {
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        view.addSubview(keyboardVC.view)
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        keyboardVC.delegate = self
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        view.addSubview(boardVC.view)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        boardVC.dataSource = self
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            
            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func set5LetterWord() {
        var ansLen = -1
        var answer = ""
        repeat {
            answer = Random.word
            ansLen = answer.count
        } while ansLen != 5
        print("answer: \(answer)")
        self.answer = answer.lowercased()
    }
}

extension ViewController: KeyboardViewControllerDelegate {
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey letter: Character) {
        var stop = false
        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = letter
                    stop = true
                    break
                }
            }
            if stop {break}
        }
        boardVC.reloadData()
    }
}

extension ViewController: BoardViewControllerDataSource {
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        let rowIndex = indexPath.section
        let count = guesses[rowIndex].compactMap({$0}).count
        guard count == 5 else {return nil}
        let indexedAnswer = Array(answer)
        
        guard let letter = guesses[indexPath.section][indexPath.row], indexedAnswer.contains(letter) else {return nil}
        
        if indexedAnswer[indexPath.row] == letter {
            return .systemGreen
        }
        return .systemYellow
    }
    var currentGuesses: [[Character?]] {
        return guesses
    }
}
