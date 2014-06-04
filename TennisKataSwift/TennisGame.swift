//
//  TennisGame.swift
//  TennisKataSwift
//
//  Created by Kin Wah Lai on 3/6/14.
//  Copyright (c) 2014 Kin Wah Lai. All rights reserved.
//

import Foundation

class Player {
    var name:NSString
    var score:Int
    init(name:NSString) {
        self.name = name
        self.score = 0
    }
    func scored() {
        self.score++
    }
}

class TennisGame {
    let tennis_score = ["Love", "Fifteen", "Thirty", "Forty"]
    let result = ["Advantage", "Won"]
    var player1, player2 :Player?
    var gameended = false
    init () {
    }
    
    func player1scored() -> (score:NSString?, exception: NSException?) {
        if let ex = self.checkPlayersExistance() {
            return (score:nil,ex)
        }
        self.player1!.scored()
        return (score:currentgamescore(), exception: nil)
    }
    
    func player1Is(name:NSString) {
        self.player1 = Player(name: name)
    }
    
    func player2scored() -> (score:NSString?, exception: NSException?) {
        if let ex = self.checkPlayersExistance() {
            return (score:nil,ex)
        }
        self.player2!.scored()
        return (score:currentgamescore(), exception: nil)
    }
    
    func checkPlayersExistance() ->NSException? {
        var ex:NSException?
        if !self.player1 || !self.player2{
            ex = NSException(name: "Tennis needs 2 player", reason: "Player name cannot be blank", userInfo: nil)
        }
        return ex?
    }
    
    func player2Is(name:NSString) {
        self.player2 = Player(name: name)
    }
    
    func currentgamescore() -> NSString {
        if (self.player1!.score + self.player2!.score <= 5) && self.leadingscore() < 4 {
            return self.basicscore()
        }
        return self.advancescore()
    }
    
    func leadingscore() ->Int {
        return self.player1!.score > self.player2!.score ? self.player1!.score : self.player2!.score
    }

    func leadingplayername() ->NSString {
        return self.player1!.score > self.player2!.score ? self.player1!.name : self.player2!.name
    }
    
    func basicscore() ->NSString {
        if self.player1!.score == self.player2!.score {
            return "\(self.tennis_score[self.player1!.score]) All"
        }
        return "\(self.tennis_score[self.player1!.score]) \(self.tennis_score[self.player2!.score])"
    }
    
    func advancescore() ->NSString {
        var diff = abs(self.player1!.score - self.player2!.score) > 2 ? 2 : abs(self.player1!.score - self.player2!.score)
        if diff == 0 {
            return "Deuce"
        }
        if diff == 2 {
            self.gameended = true
            return "\(self.leadingplayername()) \(self.result[diff-1])"
        }
        
        return "\(self.result[diff-1]) \(self.leadingplayername())"
    }
}