//
//  WALAnnotationView.h
//  Walmart
//
//  Created by wangxu on 15/9/30.
//  Copyright © 2015年 e6. All rights reserved.
//

@interface WALAnnotationView : BMKPinAnnotationView

@property (nonatomic, strong) NSString *imageName;

@end

@interface WALTrackAnnotationView : BMKAnnotationView

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, assign) NSInteger angle;

@end
