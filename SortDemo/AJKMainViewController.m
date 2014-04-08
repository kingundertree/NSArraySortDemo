//
//  AJKMainViewController.m
//  SortDemo
//
//  Created by shan xu on 14-4-8.
//  Copyright (c) 2014年 夏至. All rights reserved.
//

#import "AJKMainViewController.h"
#import "Person.h"

@interface AJKMainViewController ()

@end

@implementation AJKMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Sort method";

    [self sortArrByNum];
    [self sortArrByStr];
    [self sortArrByDic];
    [self sortObj];
}
- (void)sortArrByNum{
    NSArray *originalArray = @[@"1",@"21",@"12",@"11",@"0"];
    //block比较方法，数组中可以是NSInteger，NSString（需要转换）
    NSComparator finderSort = ^(id string1,id string2){
        if ([string1 integerValue] > [string2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }else if ([string1 integerValue] < [string2 integerValue]){
            return (NSComparisonResult)NSOrderedAscending;
        }
        else
            return (NSComparisonResult)NSOrderedSame;
    };
    //数组排序：
    NSArray *resultArray1 = [originalArray sortedArrayUsingComparator:finderSort];
    NSArray *resultArray2 = [originalArray sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"第一种排序结果：%@",resultArray1);
    NSLog(@"第二种排序结果：%@",resultArray2);
}

- (void)sortArrByStr{
    NSArray *charArray = @[@"string 1",@"String 21",@"string 12",@"String 11",@"String 02"];
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *resultArray2 = [charArray sortedArrayUsingComparator:sort];
    NSLog(@"字符串数组排序结果%@",resultArray2);
}
- (void)sortArrByDic{
    NSMutableArray *array = [NSMutableArray arrayWithObjects:
                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj0", [NSNumber numberWithInt:0], nil],
                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj5", [NSNumber numberWithInt:5], nil],
                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj2", [NSNumber numberWithInt:2], nil],
                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj3", [NSNumber numberWithInt:3], nil],
                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj1", [NSNumber numberWithInt:1], nil],
                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj4", [NSNumber numberWithInt:4], nil], nil];
    
    NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSNumber *number1 = [[obj1 allKeys] objectAtIndex:0];
        NSNumber *number2 = [[obj2 allKeys] objectAtIndex:0];
        NSComparisonResult result = [number1 compare:number2];
        
        return result == NSOrderedDescending; // 升序
    }];
    NSLog(@"resultArray-->>%@",resultArray);
}
- (void)sortObj{
    Person *person1 = [[Person alloc] init];
    [person1 setName:@"ABCD"];
    [person1 setAge:24];
    
    Person *person2 = [[Person alloc] init];
    [person2 setName:@"BCDE"];
    [person2 setAge:22];
    
    Person *person3 = [[Person alloc] init];
    [person3 setName:@"CDEF"];
    [person3 setAge:33];
    
    Person *person4 = [[Person alloc] init];
    [person4 setName:@"DEFG"];
    [person4 setAge:22];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:person1, person3, person4, person2, nil];
    
    NSSortDescriptor *sortDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];  //先按照age排序,
    NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];  //如果age相同, 按照name排序,以此类推

    NSArray *tempArray = [array sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, nil]];
    
    for(NSInteger i = 0; i < [tempArray count]; i++){
        NSLog(@"%@--------%d\n", [[tempArray objectAtIndex:i] name], [[tempArray objectAtIndex:i] age]);
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
