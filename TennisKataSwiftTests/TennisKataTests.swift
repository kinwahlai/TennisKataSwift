//
//  TennisKataTests.swift
//  TennisKataSwift
//
//  Created by Kin Wah Lai on 3/6/14.
//  Copyright (c) 2014 Kin Wah Lai. All rights reserved.
//

import XCTest

class TennisKataTests: XCTestCase {
    var tennisGame:TennisGame?
    
    override func setUp() {
        super.setUp()
        self.tennisGame = TennisGame()
        self.tennisGame!.player1Is("Jackson")
        self.tennisGame!.player2Is("Joseph")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /* Why return tuple because i cant find a way to try/catch exception in swift (maybe doesnt have try/catch) */
    func testReturnExceptionWhenNoPlayers() {
        var tennisGameWithoutPlayers:TennisGame = TennisGame()
        var (score, exception) = tennisGameWithoutPlayers.player2scored()
        XCTAssertNil(score)
        XCTAssertNotNil(exception)
        XCTAssertEqualObjects(exception!.reason, "Player name cannot be blank")
        (score, exception) = tennisGameWithoutPlayers.player1scored()
        XCTAssertNil(score)
        XCTAssertNotNil(exception)
        XCTAssertEqualObjects(exception!.reason, "Player name cannot be blank")
    }
    
    func testJacksonIsPlayer1AndJosephIsPlayer2() {
        XCTAssertEqualObjects(self.tennisGame!.player1name!, "Jackson")
        XCTAssertEqualObjects(self.tennisGame!.player2name!, "Joseph")
    }
    
    func testGameStartsWithLoveAll() {
        XCTAssertEqualObjects(self.tennisGame!.currentgamescore(), "Love All")
    }
    
    func testJacksonScoreAgainThirtyLove() {
        self.tennisGame!.player1scored()
        XCTAssertEqualObjects(self.tennisGame!.currentgamescore(), "Fifteen Love")
        self.tennisGame!.player1scored()
        XCTAssertEqualObjects(self.tennisGame!.currentgamescore(), "Thirty Love")
    }
    
    func testBothScoreOnceAndResultIsFifteenAll() {
        self.tennisGame!.player1scored()
        XCTAssertEqualObjects(self.tennisGame!.currentgamescore(), "Fifteen Love")
        self.tennisGame!.player2scored()
        XCTAssertEqualObjects(self.tennisGame!.currentgamescore(), "Fifteen All")
    }
    
    func testGameScoreThirtyForty() {
        self.runFunc(self.tennisGame!.player1scored, times: 2)
        self.runFunc(self.tennisGame!.player2scored, times: 3)
        XCTAssertEqualObjects(self.tennisGame!.currentgamescore(), "Thirty Forty")
    }
    
    func testDeuce() {
        self.runFunc(self.tennisGame!.player1scored, times: 3)
        self.runFunc(self.tennisGame!.player2scored, times: 3)
        XCTAssertEqualObjects(self.tennisGame!.currentgamescore(), "Deuce")
    }
    
    func testGivenDeuceJacksonHasAdvantage() {
        self.runFunc(self.tennisGame!.player1scored, times: 3)
        self.runFunc(self.tennisGame!.player2scored, times: 3)
        self.tennisGame!.player1scored()
        XCTAssertEqualObjects(self.tennisGame!.currentgamescore(), "Advantage Jackson")
    }

    func testJacksonWinsTheGameStraight() {
        self.runFunc(self.tennisGame!.player1scored, times: 4)
        XCTAssertEqualObjects(self.tennisGame!.currentgamescore(), "Jackson Won")
    }
    
    func testGameEndsAfterJosephWins() {
        self.runFunc(self.tennisGame!.player2scored, times: 4)
        XCTAssertEqualObjects(self.tennisGame!.currentgamescore(), "Joseph Won")
        XCTAssertEqual(self.tennisGame!.gameended, true)
    }
    
    func testGivenDeuceJacksonWon() {
        self.runFunc(self.tennisGame!.player1scored, times: 3)
        self.runFunc(self.tennisGame!.player2scored, times: 3)
        self.runFunc(self.tennisGame!.player1scored, times: 2)
        XCTAssertEqualObjects(self.tennisGame!.currentgamescore(), "Jackson Won")
    }
    
    func runFunc(function: () -> (NSString?, NSException?), times:Int) {
        for i in 0..times {
            function()
        }
    }
}

