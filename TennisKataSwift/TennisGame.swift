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
    let result = ["Advantage", "Won"]
    var player1score, player2score :Int
    var player1name, player2name :NSString?
    var gameended = false
    init () {
        self.player1score = 0; self.player2score = 0
    }
    
    func player1scored() -> (score:NSString?, exception: NSException?) {
        if let ex = self.checkPlayersExistance() {
            return (score:nil,ex)
        }
        self.player1score++
        return (score:currentgamescore(), exception: nil)
    }
    
    func player1Is(name:NSString) {
        self.player1name = name
    }
    
    func player2scored() -> (score:NSString?, exception: NSException?) {
        if let ex = self.checkPlayersExistance() {
            return (score:nil,ex)
        }
        self.player2score++
        return (score:currentgamescore(), exception: nil)
    }
    
    func checkPlayersExistance() ->NSException? {
        var ex:NSException?
        if !self.player1name || !self.player2name{
            ex = NSException(name: "Tennis needs 2 player", reason: "Player name cannot be blank", userInfo: nil)
        }
        return ex?
    }
    
    func player2Is(name:NSString) {
        self.player2name = name
    }
    
    func currentgamescore() -> NSString {
        if (self.player1score + self.player2score <= 5) && self.leadingscore() < 4 {
            return self.basicscore()
        }
        return self.advancescore()
    }
    
    func leadingscore() ->Int {
        return self.player1score > self.player2score ? self.player1score : self.player2score
    }

    func leadingplayername() ->NSString {
        return self.player1score > self.player2score ? self.player1name! : self.player2name!
    }
    
    func basicscore() ->NSString {
        if self.player1score == self.player2score {
            return "\(self.tennis_score[self.player1score]) All"
        }
        return "\(self.tennis_score[self.player1score]) \(self.tennis_score[self.player2score])"
    }
    
    func advancescore() ->NSString {
        var diff = abs(self.player1score - self.player2score) > 2 ? 2 : abs(self.player1score - self.player2score)
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