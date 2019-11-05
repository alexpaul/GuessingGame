//
//  ViewController.swift
//  GuessingGame
//
//  Created by Alex Paul on 11/5/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK:- properties and outlets
  
  @IBOutlet weak var inputTextField: UITextField!
  @IBOutlet weak var messageLabel: UILabel!
  
  // instance of GuessingGameModel 
  var guessingGameModel = GuessingGameModel()
  
  // keeps track of user's guesses
  var enteredGuesses: Set<String> = []
  
  // MARK:- life cycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    inputTextField.delegate = self
  }
  
  // MARK:- actions and methods
  
  func checkUserGuess() {
    // 1. get String from UITextField, e.g inputTextField.text
    let userInput = inputTextField.text ?? ""
    
    // keep track of entered guesses using a Set<String>
    // create a property called enteredGuesses: Set<String>
    enteredGuesses.insert(userInput)
    
    // 2. convert String to Int
    let guessNumber = Int(userInput) ?? 0
    
    // 3. call gameStatus(:_) using the guessingGameModel instance
    let result = guessingGameModel.gameStatus(guessNumber: guessNumber)
    
    if result == .correct { // get a new winningNum
      guessingGameModel = GuessingGameModel()
      enteredGuesses.removeAll()
    }
    
    // 4. set messageLabel.text with appropriate message base on the user's guess incorrect or correct
    messageLabel.text = result == .correct ? "Correct guess. 🥳" : "Incorrect guess 👎"
    messageLabel.textColor = .black
  }
}

// MARK:- UITextFieldDelegate methods
extension ViewController: UITextFieldDelegate {
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    print("textFieldShouldBeginEditing")
    return true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    print("textFieldDidBeginEditing")
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let text = textField.text else {
      return false
    }
    
    let currentText = text + string // "a" + "l" => "al"
    if enteredGuesses.contains(currentText) {
      // updates message label
      messageLabel.text = "Already guessed \(currentText)"
      messageLabel.textColor = .red
      
      // clears text field
      textField.text = ""
      
      // prevents user from typing (editing text field)
      return false
    }
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // dismiss keyboard
    textField.resignFirstResponder()
    
    checkUserGuess()

    // clear text field
    textField.text = ""
    
    return true
  }
}

