//
//  FindPasswordViewController.m
//  MiaoYouC
//
//  Created by drupem on 16/11/14.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "FindPasswordViewController.h"

@interface FindPasswordViewController () <UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *telephoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordNewTextField;
@property (weak, nonatomic) IBOutlet UIButton *getVerificationCodeButton;


@end

@implementation FindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.delegate = self;
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelBtnClick:(id)sender {
}

- (IBAction)getVerificationCodeBtnClick:(id)sender {
    NSString *phone = STR_TRIMALL(_telephoneTextField.text);
    if ([Utils isEmpty:phone]) {
        [UIHelper showMessage:localizedString(@"input_contain_null")];
    }
    else {
        if ([Utils checkMobileNumber:phone]) {
            [self p_countDown];
            [self getVerificationCode:phone];
        }
        else {
            [UIHelper showMessage:localizedString(@"mobile_invalid")];
        }
    }
}


- (IBAction)nextBtnClick:(id)sender {
    [UIHelper showHUDForView:self.view message:localizedString(@"requesting")];
    [[APIClient sharedInstance] forgetPassword:_telephoneTextField.text withCode:_verificationCodeTextField.text andPassword:_passwordNewTextField.text onSuccess:^(NSArray *objects) {
        [UIHelper hideHUDForView:self.view];
        ForgotPasswordResponse *response = [objects objectAtIndex:0];
        if ([response isSuccess]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:localizedString(@"reset_ok") completion:^(BOOL cancelled, NSInteger buttonIndex) {
                [self.navigationController popViewControllerAnimated:YES];
            } cancelButtonTitle:localizedString(@"ok") otherButtonTitles:nil, nil];
            [alert show];
            
        }
        else {
            [UIHelper showMessage:response.message];
        }
    } onError:^(NSError *error) {
        [UIHelper hideHUDForView:self.view];
        [UIHelper showMessage:localizedString(@"request_failed")];
    }];
}

#pragma mark - private

- (void)p_countDown {
    __block int time = 60;
    __block UIButton *verifybutton = _getVerificationCodeButton;
    verifybutton.enabled = NO;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [verifybutton setTitleColor:[UIColor colorWithRed:28/255.0 green:223/255.0 blue:176/255.0 alpha:1] forState:UIControlStateNormal];
                [verifybutton setTitle:localizedString(@"get_verification_code") forState:UIControlStateNormal];
                verifybutton.enabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [verifybutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                NSString *strTime = [NSString stringWithFormat:@"%d秒后重新获取",time];
                [verifybutton setTitle:strTime forState:UIControlStateNormal];
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

- (void)getVerificationCode:(NSString*)phoneNumber {
    NSString *mobile = STR_TRIMALL(_telephoneTextField.text);
    if ([Utils isEmpty:mobile] || ![Utils checkMobileNumber:mobile]) {
        [UIHelper showMessage:localizedString(@"mobile_invalid")];
        return;
    }
    [UIHelper showHUDForView:self.view message:localizedString(@"requesting")];
    [[APIClient sharedInstance] findPwdObtainCode:mobile onSuccess:^(NSArray *objects) {
        [UIHelper hideHUDForView:self.view];
        SendVerificationCodeResponse *response = [objects objectAtIndex:0];
        if ([response isSuccess]) {
            [self p_countDown];
            [UIHelper showMessage:localizedString(response.message)];
        }
        else {
            [UIHelper showMessage:response.message];
        }
    } onError:^(NSError *error) {
        [UIHelper hideHUDForView:self.view];
        [UIHelper showMessage:localizedString(@"request_failed")];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
