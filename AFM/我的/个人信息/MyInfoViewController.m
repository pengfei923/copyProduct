//
//  MyInfoViewController.m
//  AFM
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 sgamer. All rights reserved.
//

#import "MyInfoViewController.h"
#import "HeadImgTableViewCell.h"
#import "SanFangTableViewCell.h"
#import "ExitTableViewCell.h"
#import "ChengHViewController.h"
#import "NameViewController.h"
#import "LocationViewController.h"
#import "Register1ViewController.h"

@interface MyInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIAlertViewDelegate>{
    ZFUpdatePhoto *photo;
   
}
@property(nonatomic, strong) UITableView *tableView;          //列表视图
@property(nonatomic, strong) UIButton *imgButton;         //
@property(nonatomic, strong) UserModel *infoArray;         //

@end

@implementation MyInfoViewController
NSString *headImg_cellId = @"HeadImgTableViewCell";
NSString *sanFang_cellId = @"SanFangTableViewCell";
NSString *exit_cellId = @"ExitTableViewCell";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES]; //显示导航
    [self initData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initView];
//    [self initData];
}

//初始化导航栏
- (void)initNavigation {
    self.navigationItem.title = @"个人信息";
    
}


//初始化界面
- (void)initView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.tableView registerClass:[HeadImgTableViewCell class] forCellReuseIdentifier:headImg_cellId];
    [self.tableView registerClass:[SanFangTableViewCell class] forCellReuseIdentifier:sanFang_cellId];
    [self.tableView registerClass:[ExitTableViewCell class] forCellReuseIdentifier:exit_cellId];

    [self.view addSubview:self.tableView];
    if (@available(iOS 11, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
}

//初始化数据
- (void)initData {
    self.imgButton = [UIButton buttonWithType:UIButtonTypeCustom];

    
    [self initUserData];  //个人信息
    [self initDanfang];   //三方绑定

    
}

- (void)initUserData {
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=public&a=check_token&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                };
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFMHTTPSManager customSecurityPolicy]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST: urlStr parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if ([[dic objectForKey:@"error"]isEqualToNumber:@0]) {
            NSMutableDictionary *Dic = [[NSMutableDictionary alloc]initWithDictionary:[dic objectForKey:@"data"]];
            UserModel *userInfoModel = [UserModel yy_modelWithDictionary:Dic];
            self.infoArray = userInfoModel;
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//三方绑定
- (void)initDanfang {
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=user&a=check_bind&apptype=app&version=1";
    NSDictionary *paramters = @{@"user_token":self.appCache.loginViewModel.token,
                                };
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    [manager setSecurityPolicy:[AFMHTTPSManager customSecurityPolicy]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST: urlStr parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if ([[dic objectForKey:@"error"]isEqualToNumber:@0]) {
            
            NSDictionary *dictionary_data = [dic objectForKey:@"data"];
            SanModel * model = [SanModel yy_modelWithDictionary:dictionary_data];
            self.SanModelCell = model;
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];


    
   
}


#pragma mark - 列表代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }else if (section == 1) {
        return 4;
    }else{
        return 1;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0){
            return 90;
        }else{
            return 50.0f;
        }
    }else if (indexPath.section == 1){
        return 50.0f;
    }else{
        return 80.0;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            HeadImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headImg_cellId];
            cell.text_Lab.text = @"我的称号";
            cell.icon_Img.hidden = YES;
            cell.name_Lab.hidden = YES;
            return cell;

        }else if (indexPath.row == 2){
            HeadImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headImg_cellId];
            cell.text_Lab.text = @"昵称";
            cell.icon_Img.hidden = YES;
            cell.name_Lab.text = self.infoArray.username;
            return cell;

        }else if (indexPath.row == 3){
            HeadImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headImg_cellId];
            cell.text_Lab.text = @"修改密码";
            cell.icon_Img.hidden = YES;
            cell.name_Lab.hidden = YES;
            return cell;

        }else{
            HeadImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headImg_cellId];
            cell.text_Lab.text = @"头像";
            cell.name_Lab.hidden = YES;
            cell.controller = self;

            [cell.icon_Img yy_setImageWithURL:[NSURL URLWithString:self.infoArray.avatar_img] forState:UIControlStateNormal options:YYWebImageOptionRefreshImageCache];
            
            
            
            [cell.icon_Img addTarget:self action:@selector(imageViewClick:) forControlEvents:UIControlEventTouchUpInside];

            return cell;

        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            SanFangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sanFang_cellId];
            cell.name_Lab.text = @"手机";
            cell.icon_Img.image = [UIImage imageNamed:@"bind-iphone"];
            
            if (self.SanModelCell.bind_phone.length == 0 ) {
                [cell.bang_Btn setTitle:@"未绑定" forState:UIControlStateNormal];
            }else{
                cell.bang_Btn.selected = YES;
                [cell.bang_Btn setTitle:@"已绑定" forState:UIControlStateSelected];
            }
            return cell;
            
        }else if (indexPath.row == 1){
            SanFangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sanFang_cellId];
            cell.name_Lab.text = @"QQ";
            cell.icon_Img.image = [UIImage imageNamed:@"bind-qq"];
            
            if (self.SanModelCell.bind_qq.length == 0 ) {
                [cell.bang_Btn setTitle:@"未绑定" forState:UIControlStateNormal];
            }else{
                cell.bang_Btn.selected = YES;
                [cell.bang_Btn setTitle:@"已绑定" forState:UIControlStateSelected];
            }

            return cell;
            
        }else if (indexPath.row == 2){
            SanFangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sanFang_cellId];
            cell.name_Lab.text = @"新浪微博";
            cell.icon_Img.image = [UIImage imageNamed:@"bind-wb"];
            if (self.SanModelCell.bind_wb.length == 0) {
                [cell.bang_Btn setTitle:@"未绑定" forState:UIControlStateNormal];
            }else{
                cell.bang_Btn.selected = YES;
                [cell.bang_Btn setTitle:@"已绑定" forState:UIControlStateSelected];
            }

            return cell;
            
        }else {
            SanFangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sanFang_cellId];
            cell.name_Lab.text = @"微信";
            cell.icon_Img.image = [UIImage imageNamed:@"bind-wx"];
            if (self.SanModelCell.bind_wx.length == 0) {
                [cell.bang_Btn setTitle:@"未绑定" forState:UIControlStateNormal];
            }else{
                cell.bang_Btn.selected = YES;
                [cell.bang_Btn setTitle:@"已绑定" forState:UIControlStateSelected];
            }

            return cell;
       }
    }else{     //注销
        ExitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:exit_cellId];
        
        [cell.exit_Btn addTarget:self action:@selector(ecitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;

        
    }
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0){
        if (indexPath.row == 0) {      //头像
        
        }else if (indexPath.row == 1){
            ChengHViewController *myinfoVC = [[ChengHViewController alloc] init];
            myinfoVC.RANK = self.infoArray.rank;
            [myinfoVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:myinfoVC animated:YES];
        
        }else if (indexPath.row == 2){
            NameViewController *myinfoVC = [[NameViewController alloc] init];
            [myinfoVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:myinfoVC animated:YES];
        
        }else{
            Register1ViewController *passVC = [[Register1ViewController alloc] init];
            passVC.type_c = @"2";
            [passVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:passVC animated:YES];
        }

        
    }else if (indexPath.section == 1){
    }else{//注销
    }
}


//头像点击事件
- (void)imageViewClick:(UIButton *) Btn {
    [self showAlert];
}

#pragma mark - 头像选择
- (void)showAlert {
    UIAlertAction *actionLib = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pickImage];
    }];
    
    UIAlertAction *actionCam = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self snapImage];
    }];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:actionLib];
    [alertVC addAction:actionCam];
    [alertVC addAction:actionCancel];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
}


// 拍照
- (void)snapImage {
    if (!photo) {
        photo = [[ZFUpdatePhoto alloc]init:self];
        photo.allowsEditing = YES;
    }
    [photo pickImageFromAlbum:UIImagePickerControllerSourceTypeCamera];
    __weak typeof(self)weakSelf = self;
    photo.blockgetimg = ^(UIImage *file){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.imgButton setImage:file forState:UIControlStateNormal];
        [strongSelf initIconData:file];
    };
}


//从相册里找
- (void)pickImage {
    if (!photo) {
        photo = [[ZFUpdatePhoto alloc]init:self];
        photo.allowsEditing = YES;
    }
    [photo pickImageFromAlbum:UIImagePickerControllerSourceTypePhotoLibrary];
    __weak typeof(self)weakSelf = self;
    photo.blockgetimg = ^(UIImage *file){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.imgButton setImage:file forState:UIControlStateNormal];
        [strongSelf initIconData:file];
    };
}

//头像上传
- (void)initIconData:(UIImage *)imageLogo {
    NSString *urlStr = @"http://api.aifamu.com/index.php?m=user&a=upload&apptype=app&version=1";
    NSMutableDictionary *paramDic = [NSMutableDictionary new];
    [paramDic setValue:self.appCache.loginViewModel.token forKey:@"user_token"];
    
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc]initWithBaseURL:nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript",@"text/json", nil];
    [manager POST:urlStr parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData * imageData = UIImageJPEGRepresentation(imageLogo, 0.5);
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"file.jpg" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        [AppDelegate notificationRequestShowProgress:uploadProgress.fractionCompleted];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [AppDelegate notificationRequestSuccessWithStatus:@"上传成功"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [AppDelegate notificationRequestError:@"上传失败"];
    }];
}


//退出
- (void)ecitBtnClick:(UIButton *)Btn{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionLib = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * action) {
        [self cancelLogOut];
    }];
    UIAlertAction *actionCam = [UIAlertAction actionWithTitle:@"退出" style:0 handler:^(UIAlertAction * action) {
        [self sureLogOut];
    }];
    [alertVC addAction:actionLib];
    [alertVC addAction:actionCam];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}

//确认退出
- (void)sureLogOut{
    self.appCache.loginViewModel = nil;
    self.appCache.loginViewModel.token = @"";
//    [self.navigationController popViewControllerAnimated:YES];
    if (![self getUpLoginBool]) {
        return;
    }
}


- (void)cancelLogOut{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end


@implementation HeadImgModel
@end


@implementation UserModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}
@end


@implementation SanModel
@end



