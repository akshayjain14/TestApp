//
//  TableViewCell.swift
//  SoftvisionTestApp
//
//  Created by Akshay Jain on 23/09/20.
//  Copyright © 2020 akshay. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

private let myImageView: UIImageView = {
    let imageView = UIImageView(frame: .zero)
    imageView.contentMode = .scaleAspectFit
    return imageView
}()

let titleLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = UIFont(name: "Avenir-Book", size: 18)
    return label
}()

let DescriptionLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = UIFont(name: "Avenir-Book", size: 12)
    return label
}()

let imageCache = NSCache<AnyObject, AnyObject>()

override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
    setupLayouts()
}

required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}

private func setupViews() {
    contentView.clipsToBounds = true
    contentView.backgroundColor = .white
    contentView.addSubview(myImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(DescriptionLabel)
    
}

private func setupLayouts() {
    myImageView.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    DescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
myImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
myImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
    myImageView.widthAnchor.constraint(equalToConstant:60).isActive = true
    myImageView.heightAnchor.constraint(equalToConstant:60).isActive = true
    
    titleLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 30).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
    
    DescriptionLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 30).isActive = true
    DescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    DescriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.0).isActive = true
    DescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0).isActive = true
    
}

func setupImage(with imagePath: String) {
    
    guard let url = URL(string: imagePath) else {
        self.myImageView.image = nil
        return
    }
    if let imageFromCache = imageCache.object(forKey: imagePath as AnyObject) {
        self.myImageView.image = imageFromCache as? UIImage
        return
    }
    getData(from: url) { data, response, error in
        guard let data = data, error == nil else { return }
        
        DispatchQueue.main.async() { [weak self] in
            guard let imageToCache = UIImage(data: data) else { return }
            self?.imageCache.setObject(imageToCache, forKey: imagePath as AnyObject)
            self?.myImageView.image = UIImage(data: data)
        }
    }
}
func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
}
}