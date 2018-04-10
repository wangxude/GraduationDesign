
//  Created by L2H on 16/7/13.


#import "CollectviewChooseCell.h"
#define SelectNum_ItemHeight 51
#define SelectNum_ItemWidth 77
#define ItemFont1 17
#define ItemFont2 16
//加油包订购——流量包cell展示

@implementation CollectviewChooseCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return  self;
}


-(void)initView{
    
    
    _SelectIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _SelectIconBtn.userInteractionEnabled = NO;
    [_SelectIconBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_SelectIconBtn setBackgroundImage:[UIImage imageNamed:@"collectview_Unselect"] forState:UIControlStateNormal];
    [_SelectIconBtn setBackgroundImage:[UIImage imageNamed:@"collectview_Selected"] forState:UIControlStateSelected];
    [self.contentView addSubview:_SelectIconBtn];
    [_SelectIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
    _iconImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(70,70));
//        make.left.equalTo(self.contentView.mas_left).offset(5);
//        make.right.equalTo(self.contentView.mas_right).offset(-5);
       // make.top.equalTo(self.contentView.mas_top).offset(10);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    _iconImageView.layer.cornerRadius = 35;
    _iconImageView.layer.masksToBounds = YES;
   // _iconImageView.backgroundColor = [UIColor redColor];
    
    _titleLab = [[UILabel alloc]init];
    _titleLab.textColor = [UIColor darkTextColor];
    _titleLab.font = [UIFont systemFontOfSize:16];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(_iconImageView.mas_bottom).offset(5);
        //make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(10);
    }];
   // _titleLab.hidden = YES;
}

-(void)UpdateCellWithState:(BOOL)select{
    self.SelectIconBtn.selected = select;
    _isSelected = select;
}

//-(void)setData:(CommonItem *)titleItem selected:(BOOL)Selected{
//    NSString * titleStr1 = titleItem.Package_Mb;
//    NSString  * titleStr2 = titleItem.Package_Price;
//    _titleLab.text = [NSString stringWithFormat:@"%@M",titleStr1];
////    titleLab2.text = [NSString stringWithFormat:@"%@元",titleStr2];
//    if (Selected == YES) {
//        _titleLab.textColor = [UIColor blackColor];
////        titleLab2.textColor = [UIColor blackColor];
//        [_SelectIconBtn setSelected:Selected];
//        [_SelectIconBtn setBackgroundImage:[UIImage imageNamed:@"Package_selected"] forState:UIControlStateSelected];
//    }
//    else{
//        _titleLab.textColor = [UIColor lightGrayColor];
////        titleLab2.textColor = [UIColor lightGrayColor];
//        [_SelectIconBtn setSelected:Selected];
//        [_SelectIconBtn setBackgroundImage:[UIImage imageNamed:@"Package_normal"] forState:UIControlStateNormal];
//    }
//    
//}
//
//-(void)setData:(CommonItem *)titleItem index:(NSIndexPath *)indexPath{
//    [self setData:titleItem selected:YES];
//}

@end
