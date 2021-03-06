//
//  MainTutorialViewController.swift
//  TheHat
//
//  Created by Vadim Drobinin on 9/11/14.
//  Copyright (c) 2014 Vadim Drobinin. All rights reserved.
//

import UIKit

/// Tutorial class
class MainTutorialViewController: BaseViewController, UIPageViewControllerDataSource {

    /// Page view controller for different views of the tutorial
    var pageViewController : UIPageViewController?
    
    /// List of page titles
    let pageTitles = ["Настройки игроков", "Настройки слов", "Настройки времени", "Добавление игроков", "Добавление игроков",
        "Адресная книга", "Редактирование слов", "Игра", "Игра", "Редактирование раунда"]
    
    /// List of page backgrounds
    let pageImages = ["page1.png", "page2.png", "page3.png", "page1.png", "page3.png", "page1.png",
        "page3.png", "page2.png", "page3.png", "page1.png"]
    
    /// List of descriptions
    let pageDescriptions =
        ["В главных настройках можно указать количество игроков по-умолчанию и ввести имя владельца устройства.",
        "В главных настройках можно выставить сложность слов, участвующих в игре на случайных словах и ввести количество слов для каждого игрока по-умолчанию",
        "В главных настройках можно указать основное время раунда и добавочное время, в течение которого можно только ответить на сыгранное слово, но нельзя взять новое.",
        "Игроков можно добавлять из Адресной книги устройства или вручную",
        "Уже созданных игроков можно переименовывать и удалять.",
        "Адресная книга поддерживает множественное добавление игроков и поиск по именам.",
        "Редактирование слов включает в себя добавление новых и удаление/изменение старых.",
        "В процессе игры свайп вправо по экрану обозначает успешно угаданное слово, а свайп влево — «испорченное» (подробнее — в правилах игры).",
        "Результаты предыдущего раунда доступны перед началом следующего, а общие результаты — сразу после окончания игры.",
        "После окончания раунда можно изменить статусы слов, которые в нем встретились."]
    
    /// Current page index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        var pageControl: UIPageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        
        createControllers()
        showTutorial()
    }
    
    /**
        Returns to the main screen.
        
        :param: sender UIButton
    */
    @IBAction func backAction(sender: UIButton) {
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    /**
        Generates pages for the tutorial.
    */
    func showTutorial() {
        
        var startingViewController : PageContentViewController = self.viewControllerAtIndex(0)!
        var viewControllers : NSArray = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
    }
    
    /**
        Creates subviews with controllers.
    */
    func createControllers() {
        // Create page view controller
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? UIPageViewController
        self.pageViewController!.dataSource = self
        
        let startingViewController : PageContentViewController = self.viewControllerAtIndex(0)!
        let viewControllers: NSArray = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
        
        // Change the size of page view controller
        self.pageViewController!.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
        
        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)
        self.pageViewController!.didMoveToParentViewController(self)
        
    }
    
    // MARK: - Page View Controller Data Source
    
    /**
        Returns a page based on the given index.
        
        :param: index Int of the
        :returns: PageContentViewController object
    */
    func viewControllerAtIndex(index : Int) -> PageContentViewController? {
        
        if self.pageTitles.count == 0 || index >= self.pageTitles.count {
            return nil;
        }
        
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard!.instantiateViewControllerWithIdentifier("PageContentController") as PageContentViewController
        pageContentViewController.imageFile = UIImage(named:self.pageImages[index])
        pageContentViewController.titleText = self.pageTitles[index]
        pageContentViewController.descriptionText = self.pageDescriptions[index]
        pageContentViewController.pageIndex = index
        
        return pageContentViewController;
    }
    
    /**
        Shows the previous screen of the tutorial.
        
        :param: pageViewController UIPageViewController
        :param: viewController UIViewController
        
        :returns: UIViewController of nil
    */
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as PageContentViewController).pageIndex
        
        if ((index == 0) || (index == NSNotFound)) {
            return nil
        }
        
        index! -= 1
        return self.viewControllerAtIndex(index!)
    }
    
    /**
        Shows the previous screen of the tutorial.
        
        :param: pageViewController UIPageViewController
        :param: viewController UIViewController
        
        :returns: UIViewController of nil
    */
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as PageContentViewController).pageIndex
        
        if (index == NSNotFound) {
            return nil
        }
        
        index! += 1
        return self.viewControllerAtIndex(index!)
    }
    
    /**
        Shows the dots at the bottom of the screen.
        
        :param: pageViewController
        
        :returns: Int number of pages (=dots)
    */
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
