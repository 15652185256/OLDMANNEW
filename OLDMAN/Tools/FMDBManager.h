
#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface FMDBManager : NSObject
{
    FMDatabase * fm;
}
//设置单例方法
+(id)shareManager;

//添加方法 通知
-(BOOL)addNewsData:(NSDictionary*)dic;

//读取方法 通知
-(NSArray*)selectNewsData;

//查询 推送 是否有 新消息
-(NSArray*)IsSelectNewsData;

//修改 推送 查看状态
-(void)updateNewsDataByNewsID:(NSString*)NewsID Time:(NSString*)Time;

//删除方法 通知
-(void)deleteNewsDataByNewsID:(NSString*)NewsID Time:(NSString*)Time;

//添加 回复
-(BOOL)addReplyData:(NSDictionary*)dic;

//查询 回复
-(NSArray *)selectReplyData:(NSString*)NewsID;


/*
//添加 采集各个小项状态
-(void)addCollectionData:(NSDictionary*)dict;
//修改 采集各个小项状态
-(void)updateCollectionByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 采集各个小项状态
-(NSArray *)selectCollectionByShenFenZJ:(NSString*)shenFenZJ;


//添加 用户签字
-(void)addYongHuQZData:(NSDictionary*)dic;
//修改 用户签字
-(void)updateYongHuQZByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 用户签字
-(NSArray*)selectYongHuQZByShenFenZJ:(NSString*)shenFenZJ;
//删除 用户签字
-(void)deleteYongHuQZByShenFenZJ:(NSString*)shenFenZJ;


//添加 身份信息
-(void)addShenFenXXData:(NSDictionary*)dict;
//修改 身份信息
-(void)updateShenFenXXByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 身份信息
-(NSArray *)selectShenFenXXByShenFenZJ:(NSString*)shenFenZJ;
//删除 身份信息
-(void)deleteShenFenXXByShenFenZJ:(NSString*)shenFenZJ;


//添加 个人信息
-(void)addGeRenXXData:(NSDictionary*)dict;
//修改 个人信息
-(void)updateGeRenXXByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 个人信息
-(NSArray *)selectGeRenXXByShenFenZJ:(NSString*)shenFenZJ;
//删除 个人信息
-(void)deleteGeRenXXByShenFenZJ:(NSString*)shenFenZJ;



//添加 监护人信息
-(void)addJianHuRenXXData:(NSDictionary*)dict;
//修改 监护人信息
-(void)updateJianHuRenXXByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 监护人信息
-(NSArray*)selectJianHuRenXXByShenFenZJ:(NSString*)shenFenZJ;
//删除 监护人信息
-(void)deleteJianHuRenXXByShenFenZJ:(NSString*)shenFenZJ;


//添加 紧急联系人
-(void)addJinJiLXData:(NSDictionary*)dict;
//修改 紧急联系人
-(void)updateJinJiLXByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 紧急联系人
-(NSArray*)selectJinJiLXByShenFenZJ:(NSString*)shenFenZJ;
//删除 紧急联系人
-(void)deleteJinJiLXByShenFenZJ:(NSString*)shenFenZJ;


//添加 目前生活状况
-(void)addMuQianZKData:(NSDictionary*)dict;
//修改 目前生活状况
-(void)updateMuQianZKByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 目前生活状况
-(NSArray*)selectMuQianZKByShenFenZJ:(NSString*)shenFenZJ;
//删除 目前生活状况
-(void)deleteMuQianZKByShenFenZJ:(NSString*)shenFenZJ;


//添加 已确诊疾病
-(void)addYiQueZhenJBData:(NSDictionary*)dict;
//修改 已确诊疾病
-(void)updateYiQueZhenJBByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 已确诊疾病
-(NSArray*)selectYiQueZhenJBByShenFenZJ:(NSString*)shenFenZJ;
//删除 已确诊疾病
-(void)deleteYiQueZhenJBByShenFenZJ:(NSString*)shenFenZJ;


//添加 家庭主要照护者信息
-(void)addJiaTingZHData:(NSDictionary*)dict;
//修改 家庭主要照护者信息
-(void)updateJiaTingZHByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 家庭主要照护者信息
-(NSArray*)selectJiaTingZHByShenFenZJ:(NSString*)shenFenZJ;
//删除 家庭主要照护者信息
-(void)deleteJiaTingZHByShenFenZJ:(NSString*)shenFenZJ;


//添加 外部提供的专业看护服务
-(void)addWaiBuTGData:(NSDictionary*)dict;
//修改 外部提供的专业看护服务
-(void)updateWaiBuTGByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 外部提供的专业看护服务
-(NSArray*)selectWaiBuTGByShenFenZJ:(NSString*)shenFenZJ;
//删除 外部提供的专业看护服务
-(void)deleteWaiBuTGByShenFenZJ:(NSString*)shenFenZJ;


//添加 信息采集初步结果
-(void)addXinXiCJData:(NSDictionary*)dict;
//修改 信息采集初步结果
-(void)updateXinXiCJByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 信息采集初步结果
-(NSArray*)selectXinXiCJByShenFenZJ:(NSString*)shenFenZJ;
//删除 信息采集初步结果
-(void)deleteXinXiCJByShenFenZJ:(NSString*)shenFenZJ;


//添加 居家照护管理员
-(void)addJuJiaZHData:(NSDictionary*)dict;
//修改 居家照护管理员
-(void)updateJuJiaZHByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 居家照护管理员
-(NSArray*)selectJuJiaZHByShenFenZJ:(NSString*)shenFenZJ;
//删除 居家照护管理员
-(void)deleteJuJiaZHByShenFenZJ:(NSString*)shenFenZJ;




//添加 评估基本信息
-(void)addPingGuJBData:(NSDictionary*)dict;
//修改 评估基本信息
-(void)updatePingGuJBByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 评估基本信息
-(NSArray*)selectPingGuJBByShenFenZJ:(NSString*)shenFenZJ;
//删除 评估基本信息
-(void)deletePingGuJBByShenFenZJ:(NSString*)shenFenZJ;


//添加 日常生活能力
-(void)addRiChengSHData:(NSDictionary*)dict;
//修改 日常生活能力
-(void)updateRiChengSHByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 日常生活能力
-(NSArray*)selectRiChengSHByShenFenZJ:(NSString*)shenFenZJ;
//删除 日常生活能力
-(void)deleteRiChengSHByShenFenZJ:(NSString*)shenFenZJ;


//添加 精神状态
-(void)addJingShenZTData:(NSDictionary*)dict;
//修改 精神状态
-(void)updateJingShenZTByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 精神状态
-(NSArray*)selectJingShenZTByShenFenZJ:(NSString*)shenFenZJ;
//删除 精神状态
-(void)deleteJingShenZTByShenFenZJ:(NSString*)shenFenZJ;


//添加 感知觉与沟通
-(void)addGanZhiJData:(NSDictionary*)dict;
//修改 感知觉与沟通
-(void)updateGanZhiJByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 感知觉与沟通
-(NSArray*)selectGanZhiJByShenFenZJ:(NSString*)shenFenZJ;
//删除 感知觉与沟通
-(void)deleteGanZhiJByShenFenZJ:(NSString*)shenFenZJ;


//添加 社会参与
-(void)addSheHuiCYData:(NSDictionary*)dict;
//修改 社会参与
-(void)updateSheHuiCYByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 社会参与
-(NSArray*)selectSheHuiCYByShenFenZJ:(NSString*)shenFenZJ;
//删除 社会参与
-(void)deleteSheHuiCYByShenFenZJ:(NSString*)shenFenZJ;


//添加 补充评估信息
-(void)addBuChongPGData:(NSDictionary*)dict;
//修改 补充评估信息
-(void)updateBuChongPGByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 补充评估信息
-(NSArray*)selectBuChongPGByShenFenZJ:(NSString*)shenFenZJ;
//删除 补充评估信息
-(void)deleteBuChongPGByShenFenZJ:(NSString*)shenFenZJ;


//添加 能力评估结论
-(void)addNengLiPGData:(NSDictionary*)dict;
//修改 能力评估结论
-(void)updateNengLiPGByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 能力评估结论
-(NSArray*)selectNengLiPGByShenFenZJ:(NSString*)shenFenZJ;
//删除 能力评估结论
-(void)deleteNengLiPGByShenFenZJ:(NSString*)shenFenZJ;


//添加 评估补充说明
-(void)addPingGuBCData:(NSDictionary*)dict;
//修改 评估补充说明
-(void)updatePingGuBCByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 评估补充说明
-(NSArray*)selectPingGuBCByShenFenZJ:(NSString*)shenFenZJ;
//删除 评估补充说明
-(void)deletePingGuBCByShenFenZJ:(NSString*)shenFenZJ;










//添加 营养膳食
-(void)addYingYangSSData:(NSDictionary*)dict;
//修改 营养膳食
-(void)updateYingYangSSByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 营养膳食
-(NSArray*)selectYingYangSSByShenFenZJ:(NSString*)shenFenZJ;
//删除 营养膳食
-(void)deleteYingYangSSByShenFenZJ:(NSString*)shenFenZJ;


//添加 医疗卫生
-(void)addYiLiaoWSData:(NSDictionary*)dict;
//修改 医疗卫生
-(void)updateYiLiaoWSByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 医疗卫生
-(NSArray*)selectYiLiaoWSByShenFenZJ:(NSString*)shenFenZJ;
//删除 医疗卫生
-(void)deleteYiLiaoWSByShenFenZJ:(NSString*)shenFenZJ;


//添加 家庭护理
-(void)addJiaTingHLData:(NSDictionary*)dict;
//修改 家庭护理
-(void)updateJiaTingHLByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 家庭护理
-(NSArray*)selectJiaTingHLByShenFenZJ:(NSString*)shenFenZJ;
//删除 家庭护理
-(void)deleteJiaTingHLByShenFenZJ:(NSString*)shenFenZJ;


//添加 紧急救援
-(void)addJinJiJYData:(NSDictionary*)dict;
//修改 紧急救援
-(void)updateJinJiJYByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 紧急救援
-(NSArray*)selectJinJiJYByShenFenZJ:(NSString*)shenFenZJ;
//删除 紧急救援
-(void)deleteJinJiJYByShenFenZJ:(NSString*)shenFenZJ;


//添加 社区日间照料
-(void)addSheQuRJData:(NSDictionary*)dict;
//修改 社区日间照料
-(void)updateSheQuRJByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 社区日间照料
-(NSArray*)selectSheQuRJByShenFenZJ:(NSString*)shenFenZJ;
//删除 社区日间照料
-(void)deleteSheQuRJByShenFenZJ:(NSString*)shenFenZJ;


//添加 家政服务
-(void)addJiaZhengFWData:(NSDictionary*)dict;
//修改 家政服务
-(void)updateJiaZhengFWByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 家政服务
-(NSArray*)selectJiaZhengFWByShenFenZJ:(NSString*)shenFenZJ;
//删除 家政服务
-(void)deleteJiaZhengFWByShenFenZJ:(NSString*)shenFenZJ;


//添加 心理及文娱活动
-(void)addXinLiWYData:(NSDictionary*)dict;
//修改 心理及文娱活动
-(void)updateXinLiWYByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 心理及文娱活动
-(NSArray*)selectXinLiWYByShenFenZJ:(NSString*)shenFenZJ;
//删除 心理及文娱活动
-(void)deleteXinLiWYByShenFenZJ:(NSString*)shenFenZJ;


//添加 其他
-(void)addQiTaData:(NSDictionary*)dict;
//修改 其他
-(void)updateQiTaByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 其他
-(NSArray*)selectQiTaByShenFenZJ:(NSString*)shenFenZJ;
//删除 其他
-(void)deleteQiTaByShenFenZJ:(NSString*)shenFenZJ;


//添加 特殊服务需求
-(void)addTeShuFWData:(NSDictionary*)dict;
//修改 特殊服务需求
-(void)updateTeShuFWByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 特殊服务需求
-(NSArray*)selectTeShuFWByShenFenZJ:(NSString*)shenFenZJ;
//删除 特殊服务需求
-(void)deleteTeShuFWByShenFenZJ:(NSString*)shenFenZJ;


//添加 养老助餐调研
-(void)addYangLaoZCData:(NSDictionary*)dict;
//修改 养老助餐调研
-(void)updateYangLaoZCByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 养老助餐调研
-(NSArray*)selectYangLaoZCByShenFenZJ:(NSString*)shenFenZJ;
//删除 养老助餐调研
-(void)deleteYangLaoZCByShenFenZJ:(NSString*)shenFenZJ;


//添加 补充信息
-(void)addBuChongXXData:(NSDictionary*)dict;
//修改 补充信息
-(void)updateBuChongXXByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict;
//查询 补充信息
-(NSArray*)selectBuChongXXByShenFenZJ:(NSString*)shenFenZJ;
//删除 补充信息
-(void)deleteBuChongXXByShenFenZJ:(NSString*)shenFenZJ;
*/

@end
