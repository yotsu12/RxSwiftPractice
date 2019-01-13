//
//  Test2ViewModel.swift
//  RxSwiftPractice
//
//  Created by 四柳 貴光 on 2019/01/13.
//  Copyright © 2019年 giiiita. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol Test2ViewModelInput: AnyObject {
    var nameTextField: AnyObserver<String?> { get }
    var passwordTextField: AnyObserver<String?> { get }
}

protocol Test2ViewModelOutput: AnyObject {
    var validate: BehaviorRelay<Bool> { get }
}

final class Test2ViewModel: Test2ViewModelInput, Test2ViewModelOutput {
    var validate: BehaviorRelay<Bool>
    var nameTextField: AnyObserver<String?>
    var passwordTextField: AnyObserver<String?>


    private let disposeBag: DisposeBag = DisposeBag()

    init() {

        let _nameTextField = BehaviorRelay<Bool>(value: false)
        self.nameTextField = AnyObserver<String?>() { event in
            guard let text = event.element else { return }
            _nameTextField.accept((text?.count)! >= 5)
        }

        let _passwordText =  BehaviorRelay<Bool>(value: false)
        self.passwordTextField = AnyObserver<String?>() { event in
            guard let text = event.element else { return }
            _passwordText.accept((text?.count)! >= 5)
        }

        self.validate = .init(value: false)
        Observable
            .combineLatest(_nameTextField, _passwordText) { $0 && $1 }
            .bind(to: self.validate)
            .disposed(by: disposeBag)

    }
}


