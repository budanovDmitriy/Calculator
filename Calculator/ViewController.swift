//
//  ViewController.swift
//  Calculator
//
//  Created by Dmitriy Budanov on 09.03.2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Override properties

    override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
    }
    
    // MARK: - Private properties
    
    private var firstNumber: Double = 0.0
    private var symbol: String = ""
    private var isSymbolPressed: Bool = false
    
    // MARK: - IBOutlets

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    
    // MARK: - Override methods
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupButtons()
    }
    
    // MARK: - Private methods
    
    private func calculate(_ secondNumber: Double) -> Double {
        switch symbol {
        case "+": return firstNumber + secondNumber
        case "-": return firstNumber - secondNumber
        case "×": return firstNumber * secondNumber
        case "÷": return firstNumber / secondNumber
        case "%": return firstNumber * secondNumber / 100
        default: return Double(resultLabel.text!)!
        }
    }
    
    private func setupButtons(){
        buttons.forEach(){ button in
            button.layoutIfNeeded()
            button.layer.cornerRadius = button.frame.height / 2
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func pressNumbers(_ sender: UIButton) {
        let buttonText = sender.titleLabel?.text!
        let labelText = resultLabel.text!
        if buttonText == "." && labelText.contains(".") {
            return
        }
        if isSymbolPressed {
            resultLabel.text = buttonText
            isSymbolPressed = false
            return
        }
        resultLabel.text =
                "\((Double(labelText) != 0.0 || labelText.contains(".") || buttonText == ".") ? labelText : "")" +
                        "\(buttonText!)"
    }
    
    @IBAction func pressSymbol(_ sender: UIButton) {
        firstNumber = Double(resultLabel.text!)!
        symbol = (sender.titleLabel?.text)!
        isSymbolPressed = true
    }
    
    @IBAction func pressReset(_ sender: UIButton) {
        resultLabel.text = String(0)
        firstNumber = 0.0
        symbol = ""
        isSymbolPressed = false
    }
    
    @IBAction func pressCalculate(_ sender: UIButton) {
        let secondNumber = Double(resultLabel.text!)!
        let result = calculate(secondNumber)
        resultLabel.text = String(result)
        firstNumber = 0.0
        symbol = ""
        isSymbolPressed = true
    }
    
    @IBAction func pressNegative(_ sender: UIButton) {
        resultLabel.text = String(Double(resultLabel.text!)! * (-1))
        isSymbolPressed = true
    }
}

