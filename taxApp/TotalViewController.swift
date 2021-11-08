//
//  TotalViewController.swift
//  taxApp
//
//  Created by o.yuki on 2021/11/08.
//

import UIKit

class TotalViewController: UIViewController {
    @IBOutlet weak var totalLabel: UILabel!
    var totalValue: Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = decimalStyle(numStr: String(totalValue))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        totalLabel.text = decimalStyle(numStr: String(totalValue))
    }

    func decimalStyle(numStr: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        formatter.maximumFractionDigits = 25
        if let numStr = Double(numStr) {
            return formatter.string(from: NSNumber(value: numStr)) ?? "\(numStr)"
        }
        return numStr
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
