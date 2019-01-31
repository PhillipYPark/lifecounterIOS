//
//  ViewController.swift
//  Life Counter
//
//  Created by Phillip Park on 1/28/19.
//  Copyright © 2019 Phillip Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var playerArray = [Player(name: 1, life: 20), Player(name: 2, life: 20), Player(name: 3, life: 20), Player(name: 4, life: 20)]
    var playerPoints: [Int] = [20, 20, 20, 20]

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Did Load: \(playerArray.count)")
        setUpPlayers()
    }
    
    private func setUpPlayers() {
        print("Set Up Players: \(playerArray.count)")
        for n in 0...(playerArray.count - 1) {
            playerArray[n].life = playerPoints[n]
        }
        print("Set Up Players After loop: \(playerArray.count)")
    }
    
    
    func addPlayers() {
        playerArray.append(Player(name: playerArray.count, life: 20))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else {
            return UITableViewCell()
        }
        cell.player.text = String(playerArray[indexPath.row].name)
        cell.lifePoint.text = String(playerArray[indexPath.row].life)
        cell.minOne.addTarget(self, action: #selector(self.changeLifePoint(_:)), for: .touchUpInside);
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    @IBAction func changeLifePoint(_ sender: UIButton!) {
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

        switch sender.tag {
        case 0:
            playerPoints[indexPath.row] -= 1
            cell.lifePoint.text = "\(playerPoints[indexPath.row])"
            playerArray[indexPath.row].life = playerPoints[indexPath.row]
        case 1:
            playerPoints[indexPath.row] += 1
            cell.lifePoint.text = "\(playerPoints[indexPath.row])"
            playerArray[indexPath.row].life = playerPoints[indexPath.row]
        case 2:
            playerPoints[indexPath.row] -= 5
            cell.lifePoint.text = "\(playerPoints[indexPath.row])"
            playerArray[indexPath.row].life = playerPoints[indexPath.row]
        case 3:
            playerPoints[indexPath.row] += 5
            cell.lifePoint.text = "\(playerPoints[indexPath.row])"
            playerArray[indexPath.row].life = playerPoints[indexPath.row]
        default:
            break
        }
        if playerPoints[indexPath.row] <= 0 {
            let alertController = UIAlertController(title: "Game Over", message:
                "Player \(playerArray[indexPath.row].name) Loses!", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

class Player {
    let name : Int
    var life : Int
    
    init(name: Int, life: Int) {
        self.name = name
        self.life = 20
    }
}

