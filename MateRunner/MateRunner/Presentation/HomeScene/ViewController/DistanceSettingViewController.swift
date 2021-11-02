//
//  DistanceSettingViewController.swift
//  MateRunner
//
//  Created by 이유진 on 2021/11/01.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class DistanceSettingViewController: UIViewController {
    private let viewModel = DistanceSettingViewModel()
    private var disposeBag = DisposeBag()
    
    private lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "  "
        button.tintColor = .label
        return button
    }()
    
    private lazy var noticeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .notoSans(size: 16, family: .regular)
        label.text = "거리를 설정해주세요"
        return label
    }()
    
    private lazy var kilometerLabel: UILabel = {
        let label = UILabel()
        label.font = .notoSans(size: 16, family: .regular)
        label.text = "킬로미터"
        return label
    }()

    private lazy var distanceTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        // textField.font = .notoSans(size: 80, family: .black).italic
        textField.font = .systemFont(ofSize: 100, weight: .black).italic
        let attributes = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributedString = NSAttributedString(string: "5.00", attributes: attributes)
        textField.attributedText = attributedString
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.bindViewModel()
    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.disposeBag = DisposeBag()
//    }
}

// MARK: - Private Functions

private extension DistanceSettingViewController {
    func bindViewModel() {
        let input = DistanceSettingViewModel.Input(
            distance: self.distanceTextField.rx.text.orEmpty.asDriver(),
            doneButtonTapEvent: self.doneButton.rx.tap.asDriver()
        )
        
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
        output.$distanceFieldText
            .asDriver()
            .drive(self.distanceTextField.rx.text)
            .disposed(by: self.disposeBag)
        
        self.distanceTextField.rx.controlEvent(.editingDidBegin)
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.doneButton.title = "설정"
            }).disposed(by: self.disposeBag)
        
        self.doneButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.view.endEditing(true)
                self?.doneButton.title = ""
            }).disposed(by: self.disposeBag)
    }
    
    func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "목표 거리"
        self.navigationItem.rightBarButtonItem = self.doneButton
        self.view.addSubview(self.noticeLabel)
        self.noticeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(60)
        }
        self.view.addSubview(self.distanceTextField)
        self.distanceTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.noticeLabel.snp.bottom).offset(20)
        }
        self.view.addSubview(self.kilometerLabel)
        self.kilometerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.distanceTextField.snp.bottom).offset(20)
        }
    }
}
