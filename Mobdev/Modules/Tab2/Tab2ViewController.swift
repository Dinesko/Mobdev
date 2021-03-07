//
//  Tab2ViewController.swift
//  Mobdev
//
//  Created by Denis on 07.03.2021.
//

import UIKit

class Tab2ViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var chartView: ChartView!
    @IBOutlet weak var graphView: GraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            chartView.isHidden = false
            graphView.isHidden = true
        case 1:
            chartView.isHidden = true
            graphView.isHidden = false
        default:
            break
        }
    }
}
