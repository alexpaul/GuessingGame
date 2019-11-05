//
//  GuessingGameModel.swift
//  GuessingGame
//
//  Created by Alex Paul on 11/5/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

enum GameResult {
  case incorrect
  case correct
}

class GuessingGameModel {
  
  // properties
  
  // private is an access control modifier
  // other are public, internal, filePrivate, open
  private var winningNum: Int // by default access control on all properties are public
  
  // initializers
  init() {
    winningNum = Int.random(in: 18...21)
  }
  
  // methods
  func gameStatus(guessNumber: Int) -> GameResult {
    // ternary operator
    return guessNumber == winningNum ? .correct : .incorrect
  }
  
  func getWinningNumber() -> Int {
    return winningNum
  }
}
