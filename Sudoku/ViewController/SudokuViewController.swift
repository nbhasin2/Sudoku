//
//  SudokuViewController.swift
//  Sudoku
//
//  Created by Nishant on 2016-04-03.
//  Copyright © 2016 Epicara. All rights reserved.
//

import UIKit

class SudokuViewController: UIViewController, UITextFieldDelegate
{
    //  Cell Identifiers
    
    private let reuseIdentifier = "GridViewBasicCell"
    
    //  Constants
    
    let gridLayoutCellWidth = CGFloat(40)
    let gridLayoutCellHeight = CGFloat(40)
    let numberOfColumns: CGFloat = CGFloat(9)
    let gridSpacingItems: CGFloat = CGFloat(10)
    let gridSpacing: CGFloat = CGFloat(2)
    
    //  Variables
    
    @IBOutlet weak var sudokuUICollectionView: UICollectionView!
    
    //  MARK: - Constructors
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    //  MARK: - Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initializeView()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.hidden = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //  MARK: - Initializer
    
    private func initializeView()
    {
        self.sudokuUICollectionView?.registerNib((UINib(nibName: "SudokuCell", bundle: nil)), forCellWithReuseIdentifier: reuseIdentifier)
        self.sudokuUICollectionView?.scrollEnabled = true
        self.sudokuUICollectionView?.delegate = self
        self.sudokuUICollectionView?.dataSource = self
        self.sudokuUICollectionView.setContentOffset(CGPointZero, animated: true)
    }

    //  MARK: - UITextFieldDelegate - Hide Keyboard
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

// Delegate Flow Layout

extension SudokuViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let wSize = collectionView.frame.width
        let itemSize = (wSize - (gridSpacingItems * gridSpacing)) / numberOfColumns
        return CGSizeMake(itemSize, itemSize)
    }
}

// Datasource

extension SudokuViewController: UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 9
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        // Configure cell
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SudokuCell
        cell.cellText.text = "1"
        cell.cellText.delegate = self
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 9
    }
    
}
