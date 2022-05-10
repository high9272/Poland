//
//  ViewController.swift
//  TDL0308
//
//  Created by DaWoon Jeong on 2022/03/08.
//

import UIKit
import Floaty


class ViewController: UIViewController {
    
    @IBOutlet weak var writeBtn: Floaty!


    //let floaty = Floaty()

    
    private var wordList = [Word]() {
        didSet {
            self.SaveWordList()
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!

    var words = [String]()
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
//        self.add20Items()
        self.loadWordList()
        writeBtn.buttonColor = UIColor.white
 
        writeBtn.plusColor = UIColor.PlColor!
        writeBtn.handleFirstItemDirectly = true
        writeBtn.addItem(title: "") { _ in
            
            guard let VC = self.storyboard?.instantiateViewController(withIdentifier: "AddWordViewController") as? AddWordViewController else {return}
            
            //self.navigationController?.pushViewController(VC, animated: true)
            self.present(VC, animated: true, completion: nil)
            
            VC.delegate = self
            
            
        }
        self.view.addSubview(writeBtn)
        

    }
 
    
    func scrollToBottom(){
           let lastRowOfIndexPath = self.tableView.numberOfRows(inSection: 0) - 1
           DispatchQueue.main.async {
               let indexPath = IndexPath(row: lastRowOfIndexPath, section: 0)
               self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
           }
       }

         func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                
                if editingStyle == .delete {
                    
                    wordList.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    
                } else if editingStyle == .insert {
                    
                }
            } //스와이프해서 지우는 메서드


}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    } // 셀의 높이

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wordList.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EditTableCell else { return UITableViewCell() }
        let word = self.wordList[indexPath.row]
        cell.wordLabel.text = word.word
        cell.meaningLabel.text = word.meaning
       
        
        return cell
    }
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let AddWordViewController = segue.destination as? AddWordViewController{
            AddWordViewController.delegate = self
        }
    }
    
    
    
    private func SaveWordList() { //데이터 저장
        let data = self.wordList.map {
            [
                "word": $0.word,
                "meaning": $0.meaning
            ]
            
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "wordList")
        
    }
    
    private func loadWordList() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "wordList") as? [[String: Any]] else {return}
        self.wordList = data.compactMap {
            guard let word = $0["word"] as? String else {return nil}
            guard let meaning = $0["meaning"] as? String else {return nil }
            
            return Word(word: word, meaning: meaning)
            
        }
    }
    
    
}

extension ViewController: AddWordViewDelegate{
    func didSelectRegister(word: Word) {
        self.wordList.append(word)
        self.tableView.reloadData()
    }
    
    
    
}

