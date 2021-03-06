//
//  ViewController.h
//  CityGiude
//
//  Created by Dmitry Kuznetsov on 09/11/14.
//  Copyright (c) 2014 Appsgroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UIView *catalogView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UICollectionView *catalogCollectionView;

@property (nonatomic, retain) NSArray *pageContent;
@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, retain) NSTimer *pageTimer;

@property (nonatomic) BOOL isCategory;
@property (nonatomic, retain) NSString *categoryName;

@end

