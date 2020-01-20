//
//  CreateCategoryVC.swift
//  BlackSheep
//
//  Created by Martin Michalko on 08/12/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
//

import UIKit

class CreateCategoryVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var colorScrollView: UIScrollView!
    @IBOutlet weak var categoryNameTxtField: UITextField!
    @IBOutlet weak var categoryNameLine: UIView!
    
    var buttons: [ColorBtn] = []
    var colorCode:Int32 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorScrollView.showsHorizontalScrollIndicator = false
        colorScrollView.showsVerticalScrollIndicator = false
        setupCategoryScrollView()
        
        categoryNameTxtField.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        categoryNameTxtField.delegate = self
        
        

    }
    
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        
        self.save { (complete) in
            if complete {
                dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
            let category = Category(context: managedContext)
            category.color = colorCode
            category.name = categoryNameTxtField.text
        
        do {
            try managedContext.save()
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 20
    }
    
    
}


extension CreateCategoryVC: UIScrollViewDelegate {
    
    func setupCategoryScrollView() {
        
        var viewWidth =  0

        let spacing = 20
        let CategoryWH = 50
        var nextX:Int =  15
        
        
        buttons = []
        
        for subview in colorScrollView.subviews {
            subview.removeFromSuperview()
        }
        
        for i in 0..<colors.count {
            
            let button = ColorBtn()
            
            button.frame = CGRect(x: nextX, y: Int((50 / 2) - (CategoryWH/2)), width: CategoryWH, height: CategoryWH)
            button.backgroundColor = colors[i]
            button.layer.cornerRadius = CGFloat(CategoryWH / 2)
            button.addTarget(self, action:  #selector(colorElementPressed), for: .touchUpInside)
            
            nextX += CategoryWH + spacing
            
            viewWidth = nextX
    
            buttons.append(button)
            
            colorScrollView.addSubview(button)
            
            
        }
        
        self.colorScrollView.contentSize = CGSize(width: viewWidth, height: 50)
    }
    
    @objc func colorElementPressed(_ sender: CategoryBtn) {
        for btn in buttons {
            btn.unSelect()
        }
        colorCode = Int32(colors.firstIndex(of: sender.backgroundColor!)!)
        sender.select()
    }
    
    
}





