//
//  ViewController.swift
//  TennisKataSwift
//
//  Created by Kin Wah Lai on 3/6/14.
//  Copyright (c) 2014 Kin Wah Lai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var tennisGame:TennisGame = TennisGame()
    
    @IBOutlet var player1nameTextField:UITextField
    @IBOutlet var player2nameTextField:UITextField
    @IBOutlet var player1scoreButton:UIButton
    @IBOutlet var player2scoreButton:UIButton
    @IBOutlet var gamescore:UILabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updategamescore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldDidEndEditing(field: UITextField!) {
        if field == self.player1nameTextField {
            self.tennisGame.player1Is(field.text)
        }
        if field == self.player2nameTextField {
            self.tennisGame.player2Is(field.text)
        }
        field.enabled = (field.text == "")
    }
    
    @IBAction func resetgame() {
        self.tennisGame = TennisGame()
        self.player1nameTextField.text=""
        self.player2nameTextField.text=""
        self.player1nameTextField.enabled=true
        self.player2nameTextField.enabled=true
        self.player1scoreButton.enabled = true
        self.player2scoreButton.enabled = true
        self.updategamescore()
    }
    
    
    @IBAction func player1scored() {
        self.player1nameTextField.resignFirstResponder()
        self.player2nameTextField.resignFirstResponder()
        self.tennisGame.player1scored()
        self.disableButtonsAtEndGames()
        self.updategamescore()
    }
    
    @IBAction func player2scored() {
        self.player1nameTextField.resignFirstResponder()
        self.player2nameTextField.resignFirstResponder()
        self.tennisGame.player2scored()
        self.disableButtonsAtEndGames()
        self.updategamescore()
    }
    
    func updategamescore() {
        self.gamescore.text = self.tennisGame.currentgamescore()
    }
    
    func disableButtonsAtEndGames(){
        if self.tennisGame.gameended {
            self.player1scoreButton.enabled = false
            self.player2scoreButton.enabled = false
        }
    }
    
}

