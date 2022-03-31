//
//  Key.swift
//  financial_app
//
//  Created by user214203 on 3/31/22.
//

import UIKit

protocol ReusableProtocol {
    func didPressNumber(_ number: String)
    func didPressDecemial(_ value: String)
    func didPressDelete()
}

class Key: UIView {

    var delegate: ReusableProtocol? // variable to hold an instance to any object conforming to ReusableProtocol

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        // Setting the nib view to this specific view
        guard let view = loadFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }

    // Loading a view from Nib
    private func loadFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ReusableView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        if let number = sender.titleLabel?.text {
            delegate?.didPressNumber(number)
        }
    }
    
    @IBAction func didPressDecemial(_ sender: UIButton) {
        if let value = sender.titleLabel?.text {
            delegate?.didPressDecemial(value)
        }
    }
    @IBAction func didPressDelete(_ sender: UIButton) {
        delegate?.didPressDelete()
    }
}
