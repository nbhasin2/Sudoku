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
    
    var sudokuSolver: SudokuSolver?
    
    //  UI Elements
    
    @IBOutlet weak var sudokuUICollectionView: UICollectionView!
    
    //  UI Constraints 
    
    @IBOutlet weak var boardWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var boardHeightConstraint: NSLayoutConstraint!
    
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
        self.configurePerDeviceView()
        self.initializeView()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.topItem?.title = "Sudoku"
        self.navigationController!.navigationBar.barTintColor = colLightYellow
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //  MARK: - Device 
    
    private func configurePerDeviceView()
    {
        
        switch Device.size() {
        case .Screen3_5Inch:
            boardWidthConstraint.constant = CGFloat(200)
            boardHeightConstraint.constant = CGFloat(200)
        case .Screen4Inch:
            boardWidthConstraint.constant = CGFloat(250)
            boardHeightConstraint.constant = CGFloat(250)
        case .Screen4_7Inch:
            boardWidthConstraint.constant = CGFloat(300)
            boardHeightConstraint.constant = CGFloat(300)
        case .Screen5_5Inch:
            boardWidthConstraint.constant = CGFloat(350)
            boardHeightConstraint.constant = CGFloat(350)
        case .Screen7_9Inch:
            boardWidthConstraint.constant = CGFloat(350)
            boardHeightConstraint.constant = CGFloat(350)
        case .Screen9_7Inch:
            boardWidthConstraint.constant = CGFloat(400)
            boardHeightConstraint.constant = CGFloat(400)
        case .Screen12_9Inch:
            boardWidthConstraint.constant = CGFloat(500)
            boardHeightConstraint.constant = CGFloat(500)
        default:
            boardWidthConstraint.constant = CGFloat(200)
            boardHeightConstraint.constant = CGFloat(200)
        }
    }
    
    //  MARK: - Initializer
    
    private func initializeView()
    {
        self.sudokuSolver = SudokuSolver(board: sudokuGrid)
        
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
    
    
    @IBAction func solveAction(sender: UIButton)
    {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            self.sudokuSolver?.solve()
            
            dispatch_async(dispatch_get_main_queue())
            {
                self.sudokuUICollectionView.reloadData()
            }
        }
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
        cell.cellText.text = "\(sudokuSolver!.sudokuGridSolution![indexPath.section][indexPath.row])"
        cell.cellText.delegate = self
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 9
    }
    
}
