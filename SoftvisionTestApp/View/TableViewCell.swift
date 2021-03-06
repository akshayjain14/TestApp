//
//  TableViewCell.swift
//  SoftvisionTestApp
//
//  Created by Akshay Jain on 23/09/20.
//  Copyright © 2020 akshay. All rights reserved.
//

import UIKit

/// Tableview Cell class

class TableViewCell: UITableViewCell {
    /// Property ImageView for image
    private let myImageView: UIImageView = {
        let imageView = UIImageView.init(image: UIImage(named: "placeholder"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    /// Property For Title Label
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .red
        return label
    }()
    /// Property Description Label
    let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    /// TableViewCell initailization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        separatorInset = .zero
        setupViews()
        setupLayouts()
    }
    /// Required initialization
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Adding Cell Properties in contentView
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        contentView.addSubview(myImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
   /** Setting Constraint */
    private func setupLayouts() {
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        myImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        myImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        myImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        myImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 30).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 30).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0).isActive = true
        
    }
    /**setUpCellInfo  with Row
      
     - Parameters:
     - modelData: Info for cell item
     
     */
    
    func setUpCellInfo(with modelData: Rows) {
        self.descriptionLabel.text = modelData.description
        self.titleLabel.text = modelData.title
        self.myImageView.image = UIImage(named: "placeholder")
        guard let imagePath = modelData.imageHref else {
            return
        }
        self.myImageView.setImage(from: imagePath)
    }
   
    ///Reset the cell before reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
        descriptionLabel.text = ""
        titleLabel.text = ""
    }
}
