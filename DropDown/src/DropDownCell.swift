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
	
    open var selectedBackgroundColor: UIColor?
    open var highlightTextColor: UIColor?
    open var normalTextColor: UIColor?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let preferredHeight: CGFloat = 45
        
        layer.frame = .init(x: 0, y: 0, width: bounds.width, height: preferredHeight)
        
        contentView.addSubview(optionLabel)
        optionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        optionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        optionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
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
					self.backgroundColor = selectedBackgroundColor
                    self.optionLabel.textColor = self.highlightTextColor
				} else {
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
