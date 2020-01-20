//
//  emojiSelectorVC.swift
//  BlackSheep
//
//  Created by Martin Michalko on 05/12/2019.
//  Copyright © 2019 Martin Michalko. All rights reserved.
// + travelAndObjects.count + people.count + objects.count + animals.count + foodAndDrink.count

import UIKit

class EmojiSelectorVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.showsVerticalScrollIndicator = true
        collectionView.showsHorizontalScrollIndicator = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        emojiBtnText = emojiBtnTextPrevious
        dismiss(animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return activities.count
        } else if section == 1 {
            return travelAndObjects.count
        } else if section == 2 {
            return objects.count
        } else if section == 3 {
            return people.count
        } else if section == 4 {
            return animals.count
        } else if section == 5 {
            return foodAndDrink.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as! EmojiCell
        
        if indexPath.section == 0 {
            cell.emojiLabel.text = activities[indexPath.row]
            return cell
        } else if indexPath.section == 1 {
            cell.emojiLabel.text = travelAndObjects[indexPath.row]
            return cell
        } else if indexPath.section == 2 {
            cell.emojiLabel.text = objects[indexPath.row]
            return cell
        } else if indexPath.section == 3 {
            cell.emojiLabel.text = people[indexPath.row]
            return cell
        } else if indexPath.section == 4 {
            cell.emojiLabel.text = animals[indexPath.row]
            return cell
        } else if indexPath.section == 5 {
            cell.emojiLabel.text = foodAndDrink[indexPath.row]
            return cell
        } else {
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenSize.width / 8, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let createVC = storyboard?.instantiateViewController(withIdentifier: "CreateTaskVC") as! CreateTaskVC
        
        if indexPath.section == 0 {
            emojiBtnText = activities[indexPath.item]
            emojiBtnTextPrevious = activities[indexPath.item]
            dismiss(animated: true, completion: nil)
        } else if indexPath.section == 1 {
            emojiBtnText = travelAndObjects[indexPath.item]
            emojiBtnTextPrevious = travelAndObjects[indexPath.item]
            dismiss(animated: true, completion: nil)
        } else if indexPath.section == 2 {
            emojiBtnText = objects[indexPath.item]
            emojiBtnTextPrevious = objects[indexPath.item]
            dismiss(animated: true, completion: nil)
        } else if indexPath.section == 3 {
            emojiBtnText = people[indexPath.item]
            emojiBtnTextPrevious = people[indexPath.item]
            dismiss(animated: true, completion: nil)
        } else if indexPath.section == 4 {
            emojiBtnText = animals[indexPath.item]
            emojiBtnTextPrevious = animals[indexPath.item]
            dismiss(animated: true, completion: nil)
        } else if indexPath.section == 5 {
            emojiBtnText = foodAndDrink[indexPath.item]
            emojiBtnTextPrevious = foodAndDrink[indexPath.item]
            dismiss(animated: true, completion: nil)
        }

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "EmojiSectionHeaderView", for: indexPath) as? EmojiSectionHeaderView{
             if indexPath.section == 0 {
                 sectionHeader.categoryTitleLabel.text = "Activities"
                 return sectionHeader
             } else if indexPath.section == 1 {
                 sectionHeader.categoryTitleLabel.text = "Travel and Objects"
                 return sectionHeader
             } else if indexPath.section == 2 {
                 sectionHeader.categoryTitleLabel.text = "Objects"
                 return sectionHeader
             } else if indexPath.section == 3 {
                 sectionHeader.categoryTitleLabel.text = "People"
                 return sectionHeader
             } else if indexPath.section == 4 {
                 sectionHeader.categoryTitleLabel.text = "Animals and Nature"
                 return sectionHeader
             } else if indexPath.section == 5 {
                 sectionHeader.categoryTitleLabel.text = "Food and Drink"
                 return sectionHeader
             }

        }
        return UICollectionReusableView()
    }
    
}





