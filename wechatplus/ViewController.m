
//
//  ViewController.m
//  wechatplus
//
//  Created by JohnTai on 10/16/15.
//  Copyright © 2015 baozoumanhua. All rights reserved.
//

#import "ViewController.h"
#import <HealthKit/HealthKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.inputField setPlaceholder:@"请输入要增加的步数"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender {
    [self.inputField resignFirstResponder];
    
    //define unit.
    NSString *unitIdentifier = HKQuantityTypeIdentifierStepCount;
    
    //define quantityType.
    HKQuantityType *quantityTypeIdentifier = [HKObjectType quantityTypeForIdentifier:unitIdentifier];
    
    //init quantity.
    HKQuantity *quantity = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:[self.inputField.text integerValue]];
    
    //init quantity sample.
    HKQuantitySample *temperatureSample = [HKQuantitySample quantitySampleWithType:quantityTypeIdentifier quantity:quantity startDate:[NSDate date] endDate:[NSDate date] metadata:nil];
    
    //init store object.
    HKHealthStore *store = [[HKHealthStore alloc] init];
    
    //save.
    [store saveObject:temperatureSample withCompletion:^(BOOL success, NSError *error) {
        if (success) {
            
            dispatch_async(dispatch_get_main_queue(), ^(){
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"保存成功" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            });
        }else {
            
            dispatch_async(dispatch_get_main_queue(), ^(){
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"保存失败" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            });
        }
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.inputField resignFirstResponder];
}

@end
