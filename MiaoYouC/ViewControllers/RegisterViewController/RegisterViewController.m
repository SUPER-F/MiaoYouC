//
//  RegisterViewController.m
//  MiaoYouC
//
//  Created by drupem on 16/11/11.
//  Copyright © 2016年 drupem. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController () <UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *telephoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *getVerificationCodeButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.delegate = self;
    
    self.telephoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(_telephoneTextField.placeholder, nil) attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(_passwordTextField.placeholder, nil) attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelBtnClick:(UIButton *)sender {
}

- (IBAction)getVerificationCodeBtn:(UIButton *)sender {
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

- (IBAction)registButtonClick:(id)sender {
    NSString *phone = STR_TRIMALL(_telephoneTextField.text);
    NSString *code = STR_TRIMALL(_passwordTextField.text);
    if ([Utils isEmpty:phone] || [Utils isEmpty:code]) {
        [UIHelper showMessage:localizedString(@"input_contain_null")];
    }
    else {
        [self toRegister:phone withCode:code];
    }
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
    [UIHelper showHUDForView:self.view message:localizedString(@"requesting")];
    [[APIClient sharedInstance] registerVerCode:phoneNumber onSuccess:^(NSArray *objects) {
        [UIHelper hideHUDForView:self.view];
        
        SendRegistCodeResponse *response = [objects objectAtIndex:0];
        [UIHelper showMessage:localizedString(response.message)];
        
    } onError:^(NSError *error) {
        [UIHelper hideHUDForView:self.view];
        [UIHelper showMessage:localizedString(@"request_failed")];
    }];
}

- (void)toRegister:(NSString*)phoneNumber withCode:(NSString*)code {
    [UIHelper showHUDForView:self.view message:localizedString(@"requesting")];
    [[APIClient sharedInstance] confirmRegistCode:phoneNumber andCode:code onSuccess:^(NSArray *objects) {
        [UIHelper hideHUDForView:self.view];
        ConfirmRegistCodeResponse *response = [objects objectAtIndex:0];
        if ([response isSuccess]) {
//            Register2ViewController *regVC = [[Register2ViewController alloc] init];
//            regVC.teltphone = phoneNumber;
//            [appInstance pushViewController:regVC animated:YES];
        }
        else {
            [UIHelper showMessage:localizedString(@"request_failed")];
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
