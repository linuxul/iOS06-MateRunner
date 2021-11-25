//
//  LicenseViewController.swift
//  MateRunner
//
//  Created by 김민지 on 2021/11/24.
//

import UIKit

final class LicenseViewController: UIViewController {
    private lazy var licenseTextView: UITextView = {
        let textView = UITextView()
        let path = Bundle.main.path(forResource: "license", ofType: "txt") ?? ""
        let licenseText = try? String(contentsOfFile: path)
        
        textView.text = licenseText
        textView.font = .systemFont(ofSize: 14)
        textView.isEditable = false
        textView.isSelectable = false
        textView.contentInsetAdjustmentBehavior = .never
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
}

private extension LicenseViewController {
    func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "라이센스"
        
        self.view.addSubview(self.licenseTextView)
        self.licenseTextView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview().inset(10)
        }
    }
}
