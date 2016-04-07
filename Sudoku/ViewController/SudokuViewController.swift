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
    let kSections = 9 // Number of section in UICollectionView
    
    //  Variables
    
    var sudokuSolver: SudokuSolver?
    var currentBoardType: BoardType = BoardType.Puzzle
    
    //  UI Elements
    
    @IBOutlet weak var sudokuUICollectionView: UICollectionView!
    
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
    
    //  MARK: - Initializer
    
    /**
     *
     * Name         : initializeView
     *
     * Parameters   : Nothing
     *
     * Return Value : Nothing
     *
     * -- Description --
     *
     * This method is used to setup and initialize collectionview along 
     * with sudokuSolver which helps solve the puzzle.
     *
     **/
    
    private func initializeView()
    {
        self.loadingView.hidden = true
        
        self.sudokuSolver = SudokuSolver(board: sudokuGrid2)
        
        self.sudokuUICollectionView?.registerNib((UINib(nibName: "SudokuCell", bundle: nil)), forCellWithReuseIdentifier: reuseIdentifier)
        self.sudokuUICollectionView?.scrollEnabled = true
        self.sudokuUICollectionView?.delegate = self
        self.sudokuUICollectionView?.dataSource = self
        self.sudokuUICollectionView.setContentOffset(CGPointZero, animated: true)
    }
    
    //  MARK: - Device 
    
    /**
     *
     * Name         : configurePerDeviceView
     *
     * Parameters   : Nothing
     *
     * Return Value : Nothing
     *
     * -- Description --
     *
     * This method is used to modify constraint value for board at runtime
     * to support Landscape Left / Right and Portrid modes. The method is
     * also called by viewWillTransitionToSize to update constraint value.
     *
     **/
    
    private func configurePerDeviceView()
    {
        var height = CGFloat(200)
        var width = CGFloat(200)
        
        switch Device.size() {
        case .Screen3_5Inch:
            switch UIDevice.currentDevice().orientation
            {
            case .Portrait, .PortraitUpsideDown:
                height = CGFloat(200)
                width = CGFloat(200)
            case .LandscapeLeft, .LandscapeRight:
                height = CGFloat(150)
                width = CGFloat(150)
            default: break
            }
        case .Screen4Inch:
            switch UIDevice.currentDevice().orientation
            {
            case .Portrait, .PortraitUpsideDown:
                height = CGFloat(250)
                width = CGFloat(250)
            case .LandscapeLeft, .LandscapeRight:
                height = CGFloat(150)
                width = CGFloat(150)
            default: break
            }
        case .Screen4_7Inch:
            switch UIDevice.currentDevice().orientation
            {
            case .Portrait, .PortraitUpsideDown:
                height = CGFloat(300)
                width = CGFloat(300)
            case .LandscapeLeft, .LandscapeRight:
                height = CGFloat(150)
                width = CGFloat(150)
            default: break
            }
        case .Screen5_5Inch:
            switch UIDevice.currentDevice().orientation
            {
            case .Portrait, .PortraitUpsideDown:
                height = CGFloat(350)
                width = CGFloat(350)
            case .LandscapeLeft, .LandscapeRight:
                height = CGFloat(200)
                width = CGFloat(200)
            default: break
            }
        case .Screen7_9Inch:
            switch UIDevice.currentDevice().orientation
            {
            case .Portrait, .PortraitUpsideDown:
                height = CGFloat(350)
                width = CGFloat(350)
            case .LandscapeLeft, .LandscapeRight:
                height = CGFloat(300)
                width = CGFloat(300)
            default: break
            }
        case .Screen9_7Inch:
            height = CGFloat(400)
            width = CGFloat(400)
        case .Screen12_9Inch:
            height = CGFloat(500)
            width = CGFloat(500)
        default:
            break
        }
        
        boardWidthConstraint.constant = width
        boardHeightConstraint.constant = height
        
        self.sudokuUICollectionView.reloadData()
    }
    
    //  MARK: - Handle Rotation
    
    /**
     *
     * Name         : viewWillTransitionToSize
     *
     * Parameters   : Nothing
     *
     * Return Value : Nothing
     *
     * -- Description --
     *
     * This method gets called by System when device rotates. 
     * We use to update view when rotation occurs.
     *
     **/
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
    {
        configurePerDeviceView()
    }

    //  MARK: - UITextFieldDelegate - Hide Keyboard
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    /**
     *
     * Name         : toggleBoard
     *
     * Parameters   : Nothing
     *
     * Return Value : Nothing
     *
     * -- Description --
     *
     * This method is used to toggle between puzzle board and solution board.
     *
     **/
    
    func toggleBoard()
    {
        if(self.currentBoardType == BoardType.Puzzle)
        {
            self.currentBoardType = BoardType.Solved
        }
        else
        {
            self.currentBoardType = BoardType.Puzzle
        }
    }
    
    //  MARK: - Button Solve Action
    
    @IBAction func solveAction(sender: UIButton)
    {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
            // Check if it has found a solution
            // Only toggle if solution has been found 
            // If no solution is found then there is no point in toggling
            
            if(self.sudokuSolver?.hasFoundSolution() == false)
            {
                dispatch_async(dispatch_get_main_queue())
                {
                    self.loadingView.hidden = false
                }
        
                if(self.sudokuSolver!.solve() == true)
                {
                    self.currentBoardType = BoardType.Solved
                }
            }
            else
            {
                self.toggleBoard()
            }
            
            dispatch_async(dispatch_get_main_queue())
            {
                self.loadingView.hidden = true
                self.sudokuUICollectionView.reloadData()
            }
        }
    }
}

// Delegate Flow Layout

extension SudokuViewController: UICollectionViewDelegateFlowLayout
{
    /**
     *
     * Name         : collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath)
     *
     * Parameters   : Nothing
     *
     * Return Value : CGSize
     *
     * -- Description --
     *
     * This delegate method is used to handle cell item size.
     *
     **/
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let wSize = collectionView.frame.width
        let itemSize = (wSize - (gridSpacingItems * gridSpacing)) / numberOfColumns
        return CGSizeMake(itemSize, itemSize)
    }
}

// Datasource

extension SudokuViewController: UICollectionViewDataSource
{
    /**
     *
     * Name         : collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int)
     *
     * Parameters   : Nothing
     *
     * Return Value : Int
     *
     * -- Description --
     *
     * This delegate method is used to return number of items per section.
     * We get this number from current board item count.
     *
     **/
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return sudokuSolver!.getBoard(currentBoardType).count
    }
    
    /**
     *
     * Name         : collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath)
     *
     * Parameters   : Nothing
     *
     * Return Value : UICollectionViewCell
     *
     * -- Description --
     *
     * This delegate method is used to return UICollectionview cell with appropriate value from current board.
     *
     **/
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        // Configure cell
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SudokuCell
        cell.cellText.text = "\(sudokuSolver!.getBoard(currentBoardType)[indexPath.section][indexPath.row])"
        cell.cellText.delegate = self
        return cell
    }
    
    /**
     *
     * Name         : numberOfSectionsInCollectionView(collectionView: UICollectionView)
     *
     * Parameters   : Nothing
     *
     * Return Value : Int
     *
     * -- Description --
     *
     * This delegate method is used to return number of section for UICollectionview.
     * We use the constant value of 9 from kSections.
     *
     **/
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return kSections
    }
    
}
