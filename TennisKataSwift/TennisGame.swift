//
//  TennisGame.swift
//  TennisKataSwift
//
//  Created by Kin Wah Lai on 3/6/14.
//  Copyright (c) 2014 Kin Wah Lai. All rights reserved.
//

import Foundation

class TennisGame {
    let tennis_score = ["Love", "Fifteen", "Thirty", "Forty"]
    var player1score, player2score :Int
    var player1name, player2name :NSString?
    var gameended = false
    init () {
        self.player1score = 0; self.player2score = 0
    }
    
    func player1scored() -> (score:NSString?, exception: NSException?) {
        var ex:NSException?
        if !self.player1name {
            ex = NSException(name: "Tennis needs 2 player", reason: "No Player 1", userInfo: nil)
            return (score:nil,ex)
        }
        self.player1score++
        return (score:currentgamescore(), exception: ex)
    }
    
    func player1Is(name:NSString) {
        self.player1name = name
    }
    
    func player2scored() -> (score:NSString?, exception: NSException?) {
        var ex:NSException?
        if !self.player2name {
            ex = NSException(name: "Tennis needs 2 player", reason: "No Player 2", userInfo: nil)
            return (score:nil,ex)
        }
        self.player2score++
        return (score:currentgamescore(), exception: ex)
    }
    
    func player2Is(name:NSString) {
        self.player2name = name
    }
    
    func currentgamescore() -> NSString {
        if self.player1score == 4 {
            self.gameended = true
            return "\(self.player1name!) wins"
        }
        if self.player2score == 4 {
            self.gameended = true
            return "\(self.player2name!) wins"
        }
        if self.player1score == self.player2score {
            return "\(self.tennis_score[self.player1score]) All"
        }
        return "\(self.tennis_score[self.player1score]) \(self.tennis_score[self.player2score])"
    }
    
    
}