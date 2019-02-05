//
//  PlayerListTableViewController.swift
//  LifeCounter
//
//  Created by Phillip Park on 1/31/19.
//  Copyright © 2019 Phillip Park. All rights reserved.
//

import UIKit

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

class PlayerListTableViewController: UITableViewController, UITextFieldDelegate  {
    @IBOutlet var table: UITableView!
    
    struct GlobalVariable{
        static var historyArray: [String] = []
    }
    
    
    var playerArray = [Player(name: 1, life: 20, alive: true), Player(name: 2, life: 20, alive: true), Player(name: 3, life: 20, alive: true), Player(name: 4, life: 20, alive: true)]
    var playerPoints: [Int] = [20, 20, 20, 20]
    var globalLabel = UILabel()
    var playerLost = false
    static var historyArray: [String] = []
    var game = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPlayers()
    }
    
    private func setUpPlayers() {
        print("Set Up Players: \(playerArray.count)")
        for n in 0...(playerArray.count - 1) {
            playerArray[n].life = playerPoints[n]
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell") as? TableCell else {
            return UITableViewCell()
        }
        cell.player.text = String(playerArray[indexPath.row].name)
        cell.lifePoint.text = String(playerArray[indexPath.row].life)
        cell.button.addTarget(self, action: #selector(self.changeLifePoint(_:)), for: .touchUpInside)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    @IBAction func changeLifePoint(_ sender: UIButton!) {
        game = true;
        playerLost = false
        globalLabel.text = ""
        globalLabel.backgroundColor = UIColor.white
        globalLabel.textColor = UIColor.white
  
        var superview = sender.superview
        while let view = superview, !(view is UITableViewCell) {
            superview = view.superview
        }
        guard let cell = superview as? TableCell else {
            print("button is not contained in a table view cell")
            return
        }
        guard let indexPath = tableView.indexPath(for: cell) else {
            print("failed to get index path for cell containing button")
            return
        }
        let value = cell.input.text!
        if (value.isInt && playerArray[indexPath.row].alive) {
            switch sender.tag {
            case 0:
                playerPoints[indexPath.row] -= Int(cell.input.text!)!
                cell.lifePoint.text = "\(playerPoints[indexPath.row])"
                playerArray[indexPath.row].life = playerPoints[indexPath.row]
                GlobalVariable.historyArray.append("Player \(playerArray[indexPath.row].name) lost \(value) life.")
                
            case 1:
                playerPoints[indexPath.row] +=  Int(cell.input.text!)!
                cell.lifePoint.text = "\(playerPoints[indexPath.row])"
                playerArray[indexPath.row].life = playerPoints[indexPath.row]
                 GlobalVariable.historyArray.append("Player \(playerArray[indexPath.row].name) gained \(value) life.")
            default:
                break
            }
            playerLost = true
            if playerPoints[indexPath.row] <= 0 {
                playerArray[indexPath.row].alive = false
                globalLabel.text = "PLAYER \(playerArray[indexPath.row].name) LOSES!"
                globalLabel.backgroundColor = UIColor.black
                globalLabel.textColor = UIColor.red
                GlobalVariable.historyArray.append("Player \(playerArray[indexPath.row].name) LOSES!")
            }
        }
        var count : Int = 0
        for n in 0...(playerPoints.count - 1) {
            print("Im inside the loop")
            print(count)
            if playerPoints[n] > 0 {
                count += 1
            }
        }
        if count == 1 {
            game = false
            var player = 0;
            for n in 0...(playerPoints.count - 1) {
                if playerPoints[n] > 0 {
                    player = playerArray[n].name
                }
            }
            
            print("game over")
            let alert = UIAlertController(title: "GAME OVER!", message: "Player \(player) wins!", preferredStyle: .alert)
        
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            
            playerArray = [Player(name: 1, life: 20, alive: true), Player(name: 2, life: 20, alive: true), Player(name: 3, life: 20, alive: true), Player(name: 4, life: 20, alive: true)]
            playerPoints = [20, 20, 20, 20]
            game = true;
            playerLost = false
            globalLabel.text = ""
            globalLabel.backgroundColor = UIColor.white
            globalLabel.textColor = UIColor.white
            game = false
            GlobalVariable.historyArray = []

            self.table.reloadData()
            self.present(alert, animated: true)
        }
    }
    
    public override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {   
        return globalLabel
    }
    @IBAction func addPlayer(_ sender: UIButton!) {
        if (game == false && playerArray.count < 8) {
        playerArray.append(Player(name: playerArray.count + 1, life: 20, alive: true))
        playerPoints.append(20)
                tableView.beginUpdates()
                tableView.insertRows(at: [
                    NSIndexPath(row: playerArray.count-1, section: 0) as IndexPath
                    ], with: .automatic)
                tableView.endUpdates()
    }
    }
    @IBAction func resetGame(_ sender: UIButton) {
        print("I was Pressed")
        playerArray = [Player(name: 1, life: 20, alive: true), Player(name: 2, life: 20, alive: true), Player(name: 3, life: 20, alive: true), Player(name: 4, life: 20, alive: true)]
        playerPoints = [20, 20, 20, 20]
        game = true;
        playerLost = false
        globalLabel.text = ""
        globalLabel.backgroundColor = UIColor.white
        globalLabel.textColor = UIColor.white
        game = false
        GlobalVariable.historyArray = []
        self.table.reloadData()
        
    }
}

class Player {
    let name : Int
    var life : Int
    var alive : Bool
    
    init(name: Int, life: Int, alive: Bool) {
        self.name = name
        self.life = 20
        self.alive = true
    }
}
