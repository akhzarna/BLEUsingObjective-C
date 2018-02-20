//
//  DevicesSearchViewController.m
//  iwowen
//
//  Created by Ali Asghar on 10/10/13.
//  Copyright (c) 2013 Ali Asghar. All rights reserved.
//

#import "DevicesSearchViewController.h"
#import "ServiceCfg.h"
#import "RNBlurModalView.h"
#import "CustomCellDevicesCell.h"
#import "AccountViewController.h"
#import "SettingViewController.h"
#import "FourDidgitViewController.h"
#import "Globals.h"

@interface DevicesSearchViewController ()

@end

@implementation DevicesSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)tappedLeftButton:(id)sender
{
    
    NSLog(@"Left Swap");
    
    //    NSUInteger selectedIndex = [rootVC.tabBarController selectedIndex];
    //
    //    [rootVC.tabBarController setSelectedIndex:selectedIndex - 1];
    
}

- (IBAction)tappedRightButton:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    NSLog(@"Right Swapped");
    
    //    NSUInteger selectedIndex = [rootVC.tabBarController selectedIndex];
    //
    //    [rootVC.tabBarController setSelectedIndex:selectedIndex + 1];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
        
    items = [[NSMutableArray alloc]init];
    
    bt = [[BT alloc] init];
    bt.discoveryDelegate = self;
    [bt initCM];
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [_myProfileImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
    [_mySettingImageView setImage:[UIImage imageNamed:@"gray_larg.png"]];
    [_myDevicesImageView setImage:[UIImage imageNamed:@"green_larg.png"]];
    
    
    if([[NSUserDefaults standardUserDefaults] stringForKey:@"BraceletMacAddress"] != nil){
        
//        if (m_p.isConnected) {
//        
//            modal = [[RNBlurModalView alloc]initWithViewController:self title:@"Info" message:@"Bracelet Sync with the device"];
//            
//            [modal show];
//            
//            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(HideAlertView) userInfo:nil repeats:NO];
//            
//            [self scanForDevices];
//
//
//            
        }else{
        
            [self scanForDevices];
            
//            scanTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(scanForDevices) userInfo:nil repeats:YES];

//        }
        //        [bt scan];
        
        
        
//    }else{
        
//        [bt scan];
        
//        if (m_p.isConnected) {
//            
//            [self scanForDevices];
//            
//            
//        }else{
        
            [self scanForDevices];
            
//            scanTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(scanForDevices) userInfo:nil repeats:YES];
            
//        }

        
        
    }
    

}

-(void) HideAlertView{
    
    [modal hide];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillAppear:animated];
   
//    for (CBPeripheral *cb in items) {
//        [bt disconnectPeripheral:cb];
//    }
//    
//    scanTimer = nil;
//
//    [scanTimer invalidate];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scanForDevices {
    
    NSLog(@"Scan Called");
    [bt scan];
    
}

#pragma mark - BT Data Source Methods

- (void) discoveryDidRefresh:(NSMutableArray*) peripherals
{
    
    NSLog(@"discoveryDidRefresh");
    
    items = [[NSMutableArray alloc]init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    for (CBPeripheral *cb in peripherals) {
        
        NSLog(@"Cb Peripheral name is = %@",cb.name);
        NSLog(@"Cb Peripheral identifier is = %@",cb.identifier);
        
//        [Globals sharedInstance].FourDigitCode = [NSString stringWithFormat:@"%@",cb.UUID];
        
        NSString *DeviceName = [NSString stringWithFormat:@"%@",cb.name];
        
//        _fourDigitTrimmedString = [DeviceName substringFromIndex:[DeviceName length]-4];
        
        NSString *code = [DeviceName substringFromIndex: [DeviceName length] - 4];
        
        NSLog(@"Trimmed String is = %@",code);
        
        [Globals sharedInstance].FourDigitCode = code;
        
//        if ([dict objectForKey:[NSString stringWithFormat:@"%@",cb.UUID]] == nil) {
//            [items addObject:cb];
//            [dict setObject:cb forKey:[NSString stringWithFormat:@"%@",cb.UUID]];
//            [_tableView reloadData];
//        }
    
    }
    [self.tableView reloadData];
}

- (void) connectPeripheral
{
    
//    UIAlertView *alter;
//    alter = [[UIAlertView alloc] initWithTitle:@"BT" message:@"Connection successful"
//                                      delegate:nil cancelButtonTitle:nil
//                             otherButtonTitles: @"ok", nil];
//    [alter show];
    
//    [_tableView reloadData];
    
//    [self FourDidgitCodeAuth];
    
}

- (void) disconnectPeripheral
{
    [_tableView reloadData];
}

- (void) didUpdateValueForCharacteristic:(NSString*) value
{

//    UIAlertView *alter;
//    alter = [[UIAlertView alloc] initWithTitle:@"BT" message:value
//                                      delegate:nil cancelButtonTitle:nil
//                             otherButtonTitles: @"ok", nil];
//    [alter show];

}

-(void) DataSyncWithServer{
    
    
}

-(void)currentDeviceData:(DeviceData *)info{
    
    NSLog(@"%@",[info description]);
    [self syncWithServerRequest:info];

}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    
    return 4;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";

    CustomCellDevicesCell *cell;
    
    cell = (CustomCellDevicesCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
//    if([tableView respondsToSelector:@selector(dequeueReusableCellWithIdentifier:forIndexPath:)]) {
//        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    }else{
//        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    }
//    
//    if (cell == nil) {
//        
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    
//    }
    
    // Configure the Cell...
    
    if (indexPath.row == 0) {
        
//        [cell.imgCheckUnCheck setImage:[UIImage imageNamed:@"check.png"]];
        
        [cell.imgDevices setImage:[UIImage imageNamed:@"device_1.png"]];


    } else if (indexPath.row == 1){
        
        [cell.imgDevices setImage:[UIImage imageNamed:@"device_2.png"]];
        
    }else if (indexPath.row == 2){
        
        [cell.imgDevices setImage:[UIImage imageNamed:@"device_3.png"]];
        
    }else if (indexPath.row == 3){
        
        [cell.imgDevices setImage:[UIImage imageNamed:@"device_4.png"]];
    }
    
    
    if ([items count]>0) {
        
        if (indexPath.row == 0) {
            
            CBPeripheral* p = (CBPeripheral*)[items objectAtIndex:indexPath.row];
            
//            if(p.isConnected)
//            {
//                [cell.btnBound setBackgroundImage:[UIImage imageNamed:@"bind.png"] forState:UIControlStateNormal];
//            
//                [cell.imgCheckUnCheck setImage:[UIImage imageNamed:@"check.png"]];
//                
//            }
//            
//            //        cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"device-conected.png" ]];
//            else
//                //        cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"device-disconected.png" ]];
//            {
                [cell.imgCheckUnCheck setImage:[UIImage imageNamed:@"uncheck.png"]];
                [cell.btnBound setBackgroundImage:[UIImage imageNamed:@"un_bind.png"] forState:UIControlStateNormal];
                m_p = (CBPeripheral*)[items objectAtIndex:indexPath.row];
                [bt connectPeripheral:m_p];
//                [self showList];
//            }
        }
    
    }
    
    [cell.btnBound setTitle:@"Bond" forState:UIControlStateNormal];
    [cell.btnBound setBackgroundImage:[UIImage imageNamed:@"bind.png"] forState:UIControlStateNormal];
    [cell.btnBound setTag:indexPath.row];
    
    [cell.btnUnbound setTitle:@"Unbond" forState:UIControlStateNormal];
    [cell.btnUnbound setBackgroundImage:[UIImage imageNamed:@"un_bind.png"] forState:UIControlStateNormal];
    [cell.btnUnbound setTag:indexPath.row];
    [cell.btnConfig setTitle:@"Config" forState:UIControlStateNormal];
    [cell.btnConfig setBackgroundImage:[UIImage imageNamed:@"un_bind.png"] forState:UIControlStateNormal];
    [cell.btnConfig setTag:indexPath.row];
    
    [cell.btnBound addTarget:self action:@selector(BondAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnUnbound addTarget:self action:@selector(UnBondAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnConfig addTarget:self action:@selector(ConfigAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return  cell;
    
    
    // Old Code //
    
//    // Configure the cell...
//    CBPeripheral* p = (CBPeripheral*)[items objectAtIndex:indexPath.row];
//    
//    
////    cell.textLabel.text = @"Hello";
//    cell.textLabel.text = p.name;
//    
//    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
//    [cell.textLabel setTextColor:[UIColor whiteColor]];
//    
//    cell.imageView.image = [UIImage imageNamed:@"bracelets.png"];
//    
//    if(p.isConnected)
//        cell.accessoryView = [[ UIImageView alloc ]
//                              initWithImage:[UIImage imageNamed:@"device-conected.png" ]];
//    else
//        cell.accessoryView = [[ UIImageView alloc ]
//                          initWithImage:[UIImage imageNamed:@"device-disconected.png" ]];
//    
////    cell.accessoryView.frame = CGRectMake(cell.accessoryView.frame.origin.x, cell.accessoryView.frame.origin.y, 11, 18);
//    
////    cell.textLabel.font = [UIFont boldSystemFontOfSize:20.0];
////    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:8.0];
//    
//    
////    cell.detailTextLabel.textColor = [UIColor blackColor];
//    
//    return cell;
    
    
}

-(void)FourDidgitCodeAuth{
    
    [self stopProgressView];
    
    if([[NSUserDefaults standardUserDefaults] stringForKey:@"BraceletMacAddress"] != nil){
    
    }else{

    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                         bundle:nil];
    FourDidgitViewController *add =
    [storyboard instantiateViewControllerWithIdentifier:@"FourDidgitViewControllerID"];
    
//    add.FourDigitString = _fourDigitTrimmedString;
    
    [add setFourDigitString:_fourDigitTrimmedString];
    
    NSLog(@"Check Before Copy %@",_fourDigitTrimmedString);
    
    [self presentViewController:add
                       animated:YES
                     completion:nil];
        
    }
    
}

-(void)BondAction:(id)sender{
    
    if ([sender tag] == 0) {
        
        [self scanForDevices];
        
//        scanTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scanForDevices) userInfo:nil repeats:YES];
        
        [self startProgressView];
    }
    
    
}

-(void)UnBondAction:(id)sender{
   
    [bt disconnectPeripheral:m_p];

    [self disconnectPeripheral];
}

-(void)ConfigAction:(id)sender{
    
    
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    m_p = (CBPeripheral*)[items objectAtIndex:indexPath.row];
//    [self showList];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.frame.size.height/4;
}

- (IBAction)backBtnClicked:(id)sender {
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count -2] animated:YES];

}

- (void)showList {
    NSInteger numberOfOptions = 0;
    NSArray *options;
//    if (m_p.isConnected) {
//        numberOfOptions = 3;
//        options = @[
//                    @"Sync",
//                    @"Disconnect",
//                    @"Cancel"];
//    }else{
    numberOfOptions = 2;
    options = @[
                @"Connect",
                @"Cancel"];
//    }
   
    RNGridMenu *av = [[RNGridMenu alloc] initWithTitles:[options subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    //    av.itemTextAlignment = NSTextAlignmentLeft;
    av.itemFont = [UIFont boldSystemFontOfSize:18];
    av.itemSize = CGSizeMake(150, 55);
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
    
}

#pragma mark - RNGridMenuDelegate

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
    if ([item.title isEqualToString:@"Connect"]) {
        [bt connectPeripheral:m_p];
//        [self FourDidgitCodeAuth];
    }else if ([item.title isEqualToString:@"Disconnect"]) {
        [bt disconnectPeripheral:m_p];
    }else if ([item.title isEqualToString:@"Sync"]) {
        [bt readGeneralInfo:VIDONN_service_pedometer_UUID characteristicUUID:VIDONN_characteristic_pedometer_measurement_UUID];
    }
}

#pragma mark - Webservice

- (void)syncWithServerRequest:(DeviceData*)info {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString = [[NSDate alloc]init];
    
    @try{
        @autoreleasepool {
            
            [self startProgressView];
            
            NSString *params = @"plan_id=";
            params = [params stringByAppendingString:@"13"];
            params = [params stringByAppendingString:@"&user_id="];
            params = [params stringByAppendingString:[NSString stringWithFormat:@"%@",[UserDefaultsUtil getObjectForKey:@"user_id"]]];
            params = [params stringByAppendingString:@"&weight_loss="];
            params = [params stringByAppendingString:@"0"];
            params = [params stringByAppendingString:@"&steps="];
            params = [params stringByAppendingString:info.daySteps];
            params = [params stringByAppendingString:@"&distance="];
            params = [params stringByAppendingString:[NSString stringWithFormat:@"%.1f",[info.dayDistance floatValue]]];
            params = [params stringByAppendingString:@"&steps_in_last_hour="];
            params = [params stringByAppendingString:info.hourSteps];
            params = [params stringByAppendingString:@"&distance_in_last_hour="];
            params = [params stringByAppendingString:[NSString stringWithFormat:@"%.1f",[info.hourDistance floatValue]]];
            params = [params stringByAppendingString:@"&weight_lost_in_last_hour="];
            params = [params stringByAppendingString:@"0"];
            
            params = [params stringByAppendingString:@"&workout_date="];
            params = [params stringByAppendingString:[dateFormatter stringFromDate:dateFromString]];
            
            [self sendPostRequestTo:@"workout/index" withParams:params action:@selector(datasyncRequestComplete:)];
        }
    }@catch (NSException *exception) {
        NSLog(@"Exception :::: %@",[exception debugDescription]);
    }
    
}

-(void)datasyncRequestComplete:(NSData *)data{
    
    NSString *response = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [self stopProgressView];
    NSError *error;
    NSDictionary *responseDict = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&error];
    
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
    }else {
        NSString *status = [responseDict objectForKey:@"status"];
        if([status isEqualToString:@"warning"]){
        }else if ([status isEqualToString:@"failure"]){
        }else if ([status isEqualToString:@"success"]){
            modal = [[RNBlurModalView alloc]initWithViewController:self title:@"Info" message:@"Data Synced with server successfully"];
            [modal show];
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(HideAlertView) userInfo:nil repeats:NO];

        }
    }
}

-(IBAction)MyProfileAction:(id)sender{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)MySettingAction:(id)sender{
   
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)MyDevicesAction:(id)sender{
    
    
}


@end
