//
//  SimpleCell.m
//  SingleViedok
//
//  Created by LIM on 26.04.2015.
//  Copyright (c) 2015 LIM. All rights reserved.
//

#import "SimpleCell.h"

@implementation SimpleCell

@synthesize imgShow;
@synthesize TitleInfo;
@synthesize LittleInfo;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
