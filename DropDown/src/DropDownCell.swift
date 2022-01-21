//
//  DropDownCellTableViewCell.swift
//  DropDown
//
//  Created by Kevin Hirsch on 28/07/15.
//  Copyright (c) 2015 Kevin Hirsch. All rights reserved.
//

#if os(iOS)

import UIKit

open class DropDownCell: UITableViewCell {
		
	//UI
    open var optionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    open var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()
	
    open var selectedBackgroundColor: UIColor?
    open var highlightTextColor: UIColor?
    open var normalTextColor: UIColor?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let preferredHeight: CGFloat = 45
        
        layer.frame = .init(x: 0, y: 0, width: bounds.width, height: preferredHeight)
        
        contentView.addSubview(containerView)
        containerView.addSubview(optionLabel)
        
        let sharedSpacing: CGFloat = 12
        containerView.makeStickyLead(self.leadingAnchor, constant: sharedSpacing)
        containerView.makeStickyTop(self.topAnchor, constant: sharedSpacing)
        containerView.makeStickyTrail(self.trailingAnchor, constant: -sharedSpacing)
        containerView.makeStickyBottom(self.bottomAnchor, constant: -sharedSpacing)
        
        let sharedTextSpacing: CGFloat = 4
        optionLabel.makeStickyLead(self.leadingAnchor, constant: sharedTextSpacing)
        optionLabel.makeStickyTrail(self.trailingAnchor, constant: -sharedTextSpacing)
        optionLabel.makeStickyCenterY(self.centerYAnchor)
        
        self.heightAnchor.constraint(equalToConstant: preferredHeight).isActive = true
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - UI

extension DropDownCell {
	
	override open var isSelected: Bool {
		willSet {
			setSelected(newValue, animated: false)
		}
	}
	
	override open var isHighlighted: Bool {
		willSet {
			setSelected(newValue, animated: false)
		}
	}
	
	override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
		setSelected(highlighted, animated: animated)
	}
	
	override open func setSelected(_ selected: Bool, animated: Bool) {
		let executeSelection: () -> Void = { [weak self] in
			guard let `self` = self else { return }

			if let selectedBackgroundColor = self.selectedBackgroundColor {
				if selected {
                    self.containerView.backgroundColor = selectedBackgroundColor
//					self.backgroundColor = selectedBackgroundColor
                    self.optionLabel.textColor = self.highlightTextColor
				} else {
                    self.containerView.backgroundColor = .clear
					self.backgroundColor = .clear
                    self.optionLabel.textColor = self.normalTextColor
				}
			}
		}
		
		if animated {
			UIView.animate(withDuration: 0.3, animations: {
				executeSelection()
			})
		} else {
			executeSelection()
		}

		accessibilityTraits = selected ? .selected : .none
	}
	
}

#endif

import UIKit

extension UIView {
    
    private func useAutoLayout(){
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func makeStickyTop(_ constraint: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        self.useAutoLayout()
        self.topAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
    }
    
    func makeStickyLead(_ constraint: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        self.useAutoLayout()
        self.leadingAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
    }
    
    func makeStickyTrail(_ constraint: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        self.useAutoLayout()
        self.trailingAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
    }
    
    func makeStickyBottom(_ constraint: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        self.useAutoLayout()
        self.bottomAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
    }
    
    func makeStickyWidth(_ constant: CGFloat) {
        self.useAutoLayout()
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func makeStickyHeight(_ constant: CGFloat) {
        self.useAutoLayout()
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func makeStickyCenterX(_ constraint: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        self.useAutoLayout()
        self.centerXAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
    }
    
    func makeStickyCenterY(_ constraint: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        self.useAutoLayout()
        self.centerYAnchor.constraint(equalTo: constraint, constant: constant).isActive = true
    }
    
}
