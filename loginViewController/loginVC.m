
//
//  loginVC.m
//  loginViewController
//
//  Created by Dong Quoc on 9/9/16.
//  Copyright © 2016 Dong Quoc. All rights reserved.
//

#import "loginVC.h"

#define RGBColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface loginVC (){
    int screenW;
    int screenH;
}

@end

@implementation loginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    screenW = [UIScreen mainScreen].bounds.size.width;
    screenH = [UIScreen mainScreen].bounds.size.height;
    
    [self initBacground];
    
    [self initWellcomeView];
    
    [self initLoginview];
    
    //[self listFontsName];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (BOOL)shouldAutorotate
{
    return NO;
}


- (void) initBacground
{
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.view.frame];
    bg.image = [UIImage imageNamed:@"loginbg.jpg"];
    [self.view addSubview:bg];
}

- (void) initWellcomeView
{
    //HelveticaNeueLTPro-Lt
    //HelveticaNeueLTPro-UltLt
    
    UIView *welcomeview = [[UIView alloc] initWithFrame:CGRectMake(0, 142*scalef, screenW, 100)];
    
    [self.view addSubview: welcomeview];
    
    UILabel *welcome = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenW, 50)];
    welcome.text = @"GV GAME";
    [welcome setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Lt" size:32]];
    welcome.textAlignment = NSTextAlignmentCenter;
    welcome.textColor = [UIColor whiteColor];
    [welcomeview addSubview:welcome];
    
    
    
    UILabel *welcometext = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, screenW, 50)];
    welcometext.numberOfLines = 0;
    welcometext.text = @"Welcome to GV GAME application";
    [welcometext setFont:[UIFont fontWithName:@"HelveticaNeueLTPro-Lt" size:14]];
    welcometext.textAlignment = NSTextAlignmentCenter;
    welcometext.textColor = [UIColor whiteColor];
    [welcomeview addSubview:welcometext];
    
}


- (void) initLoginview
{
    NSArray* inputholder = @[@"Tên đăng nhập", @"Mật khẩu"];
    
    UIView *loginview = [[UIView alloc] initWithFrame:CGRectMake(0, 142*scalef+100, screenW, 200)];
    
    [self.view addSubview: loginview];
    int posy = 0;
    CGSize itemFrame = CGSizeMake(236, 39);
    for (int i=0; i<2; i++) {
        posy = 32+i*55;
        [self initInputField:loginview top: posy size:CGSizeMake(236, 39) holder:inputholder[i]  tag:i fontSize:16.0f];
    }
    
    [self initLoginbtn:loginview top:posy+55 size:itemFrame titleStr:@"Đăng nhập" fontSize:16.0f mybtn:loginbtn];
    
}

- (void) initInputField:(UIView*) mainview top:(int)posY size:(CGSize)inputSize holder:(NSString*)holderStr tag:(int)tag fontSize:(float)fontSize
{
    int paddingLeft = (int)(mainview.frame.size.width - inputSize.width)/2;
    
    int textPadding = paddingLeft;
    if (paddingLeft>40) { textPadding = 40; }
    UIView *inputText = [[UIView alloc] initWithFrame:CGRectMake(paddingLeft, posY, inputSize.width, inputSize.height)];
    inputText.layer.borderWidth = 0.6f;
    inputText.layer.borderColor = [UIColor whiteColor].CGColor;
    inputText.layer.cornerRadius = inputSize.height/2 - 1;
    
    [mainview addSubview:inputText];
    /*
     UIImageView *inputbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, inputSize.width, inputSize.height)];
     inputbg.image = [UIImage imageNamed:imagename];
     [inputText addSubview:inputbg];
     */
    
    UITextField *inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(textPadding, 0, inputSize.width-2*textPadding, inputSize.height)];
    inputTextField.textAlignment = NSTextAlignmentCenter;
    inputTextField.placeholder = holderStr;
    [inputText addSubview:inputTextField];
    inputTextField.tag = loginInputTag+tag;
    inputTextField.delegate=self;
    inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    if (tag==1) { inputTextField.secureTextEntry = YES;  }
    [inputTextField setValue:RGBColor(0xffffff) forKeyPath:@"_placeholderLabel.textColor"];
    [inputTextField setValue:[UIFont fontWithName:@"HelveticaNeueLTPro-Lt" size:fontSize] forKeyPath:@"_placeholderLabel.font"];
    
    inputTextField.font = [UIFont fontWithName:@"HelveticaNeueLTPro-Lt" size:fontSize];
    inputTextField.textColor = RGBColor(0xffffff);
    
    inputTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //[inputTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
}

- (void) initLoginbtn:(UIView*) mainview top:(int)posY size:(CGSize)inputSize titleStr:(NSString*)titleStr fontSize:(float)fontSize mybtn:(UIButton*)mybtn
{
    int paddingLeft = (int)(mainview.frame.size.width - inputSize.width)/2;
    mybtn = [[UIButton alloc] initWithFrame:CGRectMake(paddingLeft, posY, inputSize.width, inputSize.height)];
    mybtn.layer.borderWidth = 0.6f;
    mybtn.layer.borderColor = RGBColor(0x30ad64).CGColor;
    mybtn.layer.cornerRadius = inputSize.height/2 - 1;
    mybtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeueLTPro-Lt" size:fontSize];
    [mybtn setTitle:titleStr forState:UIControlStateNormal];
    mybtn.backgroundColor = RGBColor(0x30ad64);
    
    [mainview addSubview:mybtn];
    
    [mybtn addTarget:self action:@selector(loginfunction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginfunction
{
    NSLog(@"Login now");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) listFontsName
{
    for (NSString *familyName in [UIFont familyNames]){
        NSLog(@"Family name: %@", familyName);
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"--Font name: %@", fontName);
        }
    }
}



#pragma UITextField move up when keyboard present

/*
 *  Delegate thằng input nào muốn đẩy
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES]; // dismiss the keyboard
    [super touchesBegan:touches withEvent:event];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textViewDidBeginEditing");
    [self animateTextField: textField up: YES];
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"textViewDidEndEditing : %@", textField.text);
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 120; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        self.view.frame = CGRectOffset(self.view.frame, movement, 0);
    } else {
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    }
    
    [UIView commitAnimations];
}


@end
