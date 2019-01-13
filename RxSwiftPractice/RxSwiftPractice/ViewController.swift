//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by 四柳 貴光 on 2019/01/13.
//  Copyright © 2019年 giiiita. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    typealias Input = Test2ViewModelInput
    typealias Output = Test2ViewModelOutput

    let input: Input = Test2ViewModel()
    let output: Output = Test2ViewModel()
    private let disposeBag: DisposeBag = DisposeBag()

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameTextField.rx.text.orEmpty
            .bind(to: input.nameTextField)
            .disposed(by: self.disposeBag)

        self.passwordTextField.rx.text.orEmpty
            .bind(to: input.passwordTextField)
            .disposed(by: self.disposeBag)

        output.validate
            .bind(to: self.registerButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
    }
    
}

