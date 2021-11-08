//
//  ViewController.swift
//  taxApp
//
//  Created by o.yuki on 2021/11/08.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var taxSegment: UISegmentedControl!
    @IBOutlet weak var resultsTableView: UITableView!
    var taxRate: Double = 1.1
    var results: [String] = []
    var total: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.keyboardType = UIKeyboardType.numberPad
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
    }

    @objc func textFieldDidChange(sender: UITextField) {
        showResult()
    }
    
    @IBAction func taxSegmentChanged(_ sender: Any) {
        showResult()
    }
    
    @IBAction func addPriceButton(_ sender: Any) {
        var dNum: Double = NSString(string: resultLabel.text!).doubleValue
        total = total + dNum
//        results.append("\(resultLabel.text!)")
        results.append(resultLabel.text!)
        resultsTableView.reloadData()
    }
    
    
    func showResult() {
        if taxSegment.selectedSegmentIndex == 0 {
            taxRate = 1.1
        } else {
            taxRate = 1.08
        }
        if textField.text != "" {
            let textFieldNum:NSDecimalNumber? = NSDecimalNumber(string: textField.text)
            resultLabel.text = textFieldNum!.multiplying(by: NSDecimalNumber(value: taxRate)).stringValue
        } else {
            resultLabel.text = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNext" {
            let nextView = segue.destination as! TotalViewController
            nextView.totalValue = total
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        cell.textLabel?.text = results[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            var dNum: Double = NSString(string: results[indexPath.row]).doubleValue
            total = total - dNum
            results.remove(at: indexPath.row)
            resultsTableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            print(total)
        }
    }
}

