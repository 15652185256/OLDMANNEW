
#import "FMDBManager.h"

#import "JpushNewsModel.h"//通知 数据模型

#import "JpushReplyModel.h"//回复 数据模型

#import "CollectModel.h"//采集小项状态

#import "ShenFenXXModel.h"//身份信息
#import "GeRenXXModel.h"//个人信息
#import "JianHuRenXXModel.h"//监护人信息 紧急联系人信息
#import "MuQianZKModel.h"//目前生活状况
#import "YiQueZhenJBModel.h"//已确诊的疾病
#import "JiaTingZHModel.h"//家庭主要照护者信息
#import "WaiBuTGModel.h"//外部提供专业看护服务
#import "XinXiCJModel.h"//信息采集初步结果
#import "JuJiaZHModel.h"//居家照护管理员信息

#import "PingGuJBModel.h"//评估基本信息
#import "RiChengSHModel.h"//日常生活能力
#import "JingShenZTModel.h"//精神状态
#import "GanZhiJModel.h"//感知觉与沟通
#import "SheHuiCYModel.h"//社会参与
#import "BuChongPGModel.h"//补充评估信息
#import "NengLiPGModel.h"//能力评估信息
#import "ZhuZePGModel.h"//主责评估员信息
#import "PingGuBCModel.h"//评估补充说明


#import "YingYangSSModel.h"//营养膳食
#import "YiLiaoWSModel.h"//医疗卫生
#import "JiaTingHLModel.h"//家庭护理
#import "JinJiJYModel.h"//紧急救援
#import "SheQuRJModel.h"//社区日间照料
#import "JiaZhengFWModel.h"//家政服务
#import "XinLiWYModel.h"//心理及文娱活动
#import "QiTaModel.h"//其他
#import "TeShuFWModel.h"//特殊服务需求
#import "YangLaoZCModel.h"//养老助餐调研
#import "BuChongXXModel.h"//补充信息



static FMDBManager * manager=nil;
@implementation FMDBManager
+(id)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //GCD方式创建单例，保证此方法只调用一次
        manager=[[FMDBManager alloc]init];
    });
    return manager;
}


//查询表是否存在
- (BOOL)isTableOK:(NSString *)tableName
{
    FMResultSet *rs = [fm executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        NSInteger count = [rs intForColumn:@"count"];
        
        if (count == 0){
            return NO;
        } else {
            return YES;
        }
    }
    return NO;
}

////查询 表 是否 存在 字段
//- (BOOL)columnExists:(NSString*)columnName inTableWithName:(NSString*)tableName
//{
//    NSString * sql = [NSString stringWithFormat:@"SELECT %@ FROM %@", columnName, tableName];
//    FMResultSet * rs = [fm executeQuery:sql];
//    if (rs) {
//        return YES;
//    }
//    [rs close];
//    return NO;
//}




-(id)init
{
    if (self=[super init]) {
        //设置一个缓存路径
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * docDir = [paths objectAtIndex:0];
        
        //创建数据库
        fm=[[FMDatabase alloc]initWithPath:[NSString stringWithFormat:@"%@/data.db",docDir]];
        
        //打开数据
        if ([fm open]) {
            
            
            if (![self isTableOK:@"JpushNews"]) {
                //创建表格 推送
                [fm executeUpdate:@"create table JpushNews (time,content,NewsID,DocID,state)"];
            }
            
            if (![self isTableOK:@"JpushReply"]) {
                //创建表格 回复
                [fm executeUpdate:@"create table JpushReply (time,content,NewsID)"];
            }
            
            
            
            
            if (![self isTableOK:@"Collection"]) {
                //创建表格 采集各个小项状态
                [fm executeUpdate:@"create table Collection (doc_id,shenFenZJ,yongHuQZ,shenFenXX,geRenXX,jianHuRenXX,jinJiLX,muQianZK,yiQueZhenJB,jiaTingZH,waiBuTG,xinXiCJ,juJiaZH)"];
            }
            
            
    
            
            if (![self isTableOK:@"YongHuQZ"]) {
                //创建表格 用户签字
                [fm executeUpdate:@"create table YongHuQZ (doc_id,shenFenZJ,agree1,agree2,agree3,qianMing)"];
            }
            
            if (![self isTableOK:@"ShenFenXX"]) {
                //创建表格 身份信息
                [fm executeUpdate:@"create table ShenFenXX (doc_id,shenFenZJ,xingMing,yiBaoKH,canJiJR,canJiRZ)"];
            }
            
            if (![self isTableOK:@"GeRenXX"]) {
                //创建表格 个人信息
                [fm executeUpdate:@"create table GeRenXX (doc_id,shenFenZJ,tableFlag,xingBie,chuShengRQ,minZu,zhongJiaoXY,hunYinZK,wenHuaCD,jiGuanSheng,jiGuanShi,shiYongYY,huJiSheng,huJiShi,huJiQu,huJiJie,huJiSheQu,huJiAddress,juZhuSheng,juZhuShi,juZhuQu,juZhuJie,juZhuSheQu,juZhuAddress,zhuZhaiDH,yiDongDH,youZhengBM,dianZiYX)"];
            }
            
            if (![self isTableOK:@"JianHuRenXX"]) {
                //创建表格 监护人信息
                [fm executeUpdate:@"create table JianHuRenXX (doc_id,shenFenZJ,tableFlag,jianHuRX,yuLaoRG,juZhuSheng,juZhuShi,juZhuQu,juZhuJie,juZhuSheQu,juZhuAddress,zhuZhaiDH,yiDongDH,youZhengBM,dianZiYX)"];
            }
            
            if (![self isTableOK:@"JinJiLX"]) {
                //创建表格 紧急联系人信息
                [fm executeUpdate:@"create table JinJiLX (doc_id,shenFenZJ,tableFlag,jianHuRX,yuLaoRG,juZhuSheng,juZhuShi,juZhuQu,juZhuJie,juZhuSheQu,juZhuAddress,zhuZhaiDH,yiDongDH,youZhengBM,dianZiYX)"];
            }
            
            if (![self isTableOK:@"MuQianZK"]) {
                //创建表格 目前生活状况
                [fm executeUpdate:@"create table MuQianZK (doc_id,shenFenZJ,tableFlag,juZhuQK,jingJiLY,tongZhuPO,ziJinKN,juZhuHJ,yiLiaoZF,qiTaZK)"];
            }
            
            if (![self isTableOK:@"YiQueZhenJB"]) {
                //创建表格 已确诊的疾病
                [fm executeUpdate:@"create table YiQueZhenJB (doc_id,shenFenZJ,tableFlag,chuanRanJB,fengXianGW,yinShiXZ,qiTaJB)"];
            }
            
            if (![self isTableOK:@"JiaTingZH"]) {
                //创建表格 家庭主要照护者信息
                [fm executeUpdate:@"create table JiaTingZH (doc_id,shenFenZJ,tableFlag,xingMing,nianLing,xingBie,yuLaoRG,juZhuSheng,juZhuShi,juZhuQu,juZhuJie,juZhuSheQu,juZhuAddress,yuLaoRT,youZhengBM,zhuZhaiDH,yiDongDH,dianZiYX,jiaTingZHZT,jiaTingCY5H,jiaTingCY5M,jiaTingCY2H,jiaTingCY2M,jiaTingZHRY)"];
            }
            
            if (![self isTableOK:@"WaiBuTG"]) {
                //创建表格 外部提供专业看护服务
                [fm executeUpdate:@"create table WaiBuTG (doc_id,shenFenZJ,tableFlag,guWenHQD,guWenHQH,guWenHQM,geRenSSD,geRenSSH,geRenSSM,juJiaSSD,juJiaSSH,juJiaSSM,kanHuMB,kanHuXQ)"];
            }
            
            if (![self isTableOK:@"XinXiCJ"]) {
                //创建表格 信息采集初步结果
                [fm executeUpdate:@"create table XinXiCJ (doc_id,shenFenZJ,tableFlag,chuBuYX,chuPingJY)"];
            }
            
            if (![self isTableOK:@"JuJiaZH"]) {
                //创建表格 居家照护管理员信息
                [fm executeUpdate:@"create table JuJiaZH (doc_id,shenFenZJ,tableFlag,xingMing,suoShuJG,juZhuSheng,juZhuShi,juZhuQu,juZhuJie,juZhuSheQu,juZhuAddress,zhuZhaiDH,yiDongDH,youZhengBM,dianZiYX)"];
            }
            
            
            
            
            
            
            if (![self isTableOK:@"PingGuJB"]) {
                //创建表格 评估基本信息
                [fm executeUpdate:@"create table PingGuJB (doc_id,shenFenZJ,tableFlag,pingGuZ,xingMing,nianLing,lianXiDH,yuLaoRG,pingGuYY,saiCha)"];
            }
            
            if (![self isTableOK:@"RiChengSH"]) {
                //创建表格 日常生活能力
                [fm executeUpdate:@"create table RiChengSH (doc_id,shenFenZJ,tableFlag,jinShi,xiZao,xiuShi,chuanYi,daBianKZ,xiaoBianKZ,ruCe,chuangYiZY,pingDiXZ,shangXiaLT,riChangSSHDFJ,riChangSSHDZF)"];
            }
            
            if (![self isTableOK:@"JingShenZT"]) {
                //创建表格 精神状态
                [fm executeUpdate:@"create table JingShenZT (doc_id,shenFenZJ,tableFlag,renZhiGN,gongJiXW,yiYuZZ,jingShenZTFJ,jingShenZTZF)"];
            }
            
            if (![self isTableOK:@"GanZhiJ"]) {
                //创建表格 感知觉与沟通
                [fm executeUpdate:@"create table GanZhiJ (doc_id,shenFenZJ,tableFlag,yiShiSP,shiLi,tingLi,gouTongJL,ganZhiJYGTFJ,ganZhiJYGTZF)"];
            }
            
            if (![self isTableOK:@"SheHuiCY"]) {
                //创建表格 社会参与
                [fm executeUpdate:@"create table SheHuiCY (doc_id,shenFenZJ,tableFlag,shengHuoNL,gongZuoNL,shiJianKJ,renWuDX,sheHuiJW,sheHuiCYFJ,sheHuiCYZF)"];
            }
            
            if (![self isTableOK:@"BuChongPG"]) {
                //创建表格 补充评估信息
                [fm executeUpdate:@"create table BuChongPG (doc_id,shenFenZJ,tableFlag,laoNianCZ,jingShenJB,dieDao,yeShi,zouShi,ziSha)"];
            }
            
            if (![self isTableOK:@"NengLiPG"]) {
                //创建表格 能力评估结论
                [fm executeUpdate:@"create table NengLiPG (doc_id,shenFenZJ,tableFlag,riChangSH,jingShenZT,ganZhiJY,sheHuiCY,nengLiDJ,dengJiBG,nengLiZZ)"];
            }
            
            if (![self isTableOK:@"QianMing"]) {
                //创建表格 评估员签名
                [fm executeUpdate:@"create table QianMing (doc_id,qianming)"];
            }
            
            if (![self isTableOK:@"PingGuBC"]) {
                //创建表格 评估补充说明
                [fm executeUpdate:@"create table PingGuBC (doc_id,shenFenZJ,tableFlag,pingGuBC)"];
            }
            
            
            
            
            
            if (![self isTableOK:@"YingYangSS"]) {
                //创建表格 营养膳食
                [fm executeUpdate:@"create table YingYangSS (doc_id,shenFenZJ,tableFlag,need,yingYangSS,sanShiZB,songCan,jinShiFW)"];
            }
            
            if (![self isTableOK:@"YiLiaoWS"]) {
                //创建表格 医疗卫生
                [fm executeUpdate:@"create table YiLiaoWS (doc_id,shenFenZJ,tableFlag,need,shengLiZB,dingQiJX,dingQiJC,kangFuDL,dingQiPT)"];
            }
            
            if (![self isTableOK:@"JiaTingHL"]) {
                //创建表格 家庭护理
                [fm executeUpdate:@"create table JiaTingHL (doc_id,shenFenZJ,tableFlag,need,qiChuangJQ,zhuYu,geRenXS,ruCeTX,dingQiGH,daXiaoPB,fuYaoJC,yaChuangHL,jiaTingZHZJ,jiaTingZHZT,jiaTingZHFW)"];
            }
            
            if (![self isTableOK:@"JinJiJY"]) {
                //创建表格 紧急救援
                [fm executeUpdate:@"create table JinJiJY (doc_id,shenFenZJ,tableFlag,need,anZhuangAQ,dingQiJT,jiaTingKJ,yuanChengAQ,yingJiJY)"];
            }
            
            if (![self isTableOK:@"SheQuRJ"]) {
                //创建表格 社区日间照料
                [fm executeUpdate:@"create table SheQuRJ (doc_id,shenFenZJ,tableFlag,need,yingYangSS,geRenSS,fuYaoGL,kangFuXL,yiWuXD,xinLiSD,sheJiaoYL)"];
            }
            
            
            if (![self isTableOK:@"JiaZhengFW"]) {
                //创建表格 家政服务
                [fm executeUpdate:@"create table JiaZhengFW (doc_id,shenFenZJ,tableFlag,need,caiGouRC,jiaTingQJ,chuangShangYP,xiDiZL,duLiSS)"];
            }
            
            if (![self isTableOK:@"XinLiWY"]) {
                //创建表格 心理及文娱活动
                [fm executeUpdate:@"create table XinLiWY (doc_id,shenFenZJ,tableFlag,need,shengHuoJN,guanHuanFS,sheJiaoSS,jiaTingWH,xinLiZX,buLiangQX,chuXingJH)"];
            }
            
            if (![self isTableOK:@"QiTa"]) {
                //创建表格 其他
                [fm executeUpdate:@"create table QiTa (doc_id,shenFenZJ,tableFlag,need,ruZhuYL,duanQiSQ,fuJuPZ,gouMaiCQ,gouMaiYW)"];
            }
            
            if (![self isTableOK:@"TeShuFW"]) {
                //创建表格 特殊服务需求
                [fm executeUpdate:@"create table TeShuFW (doc_id,shenFenZJ,tableFlag,need,teShuFW1,teShuFW2,teShuFW3,teShuFW4,teShuFW5,teShuFW6)"];
            }
            
            if (![self isTableOK:@"YangLaoZC"]) {
                //创建表格 养老助餐调研
                [fm executeUpdate:@"create table YangLaoZC (doc_id,shenFenZJ,tableFlag,juZhuQK,yueShouRQ,ninShiFS,shiFouXY,ninXuYP,ninSongCL,ninRenWP,ninDuiYS,ninDuiYL)"];
            }
            
            if (![self isTableOK:@"BuChongXX"]) {
                //创建表格 补充信息
                [fm executeUpdate:@"create table BuChongXX (doc_id,shenFenZJ,tableFlag,buChongXX)"];
            }
            
        }
    }
    return self;
}




//添加 推送
-(BOOL)addNewsData:(NSDictionary*)dic
{
    return [fm executeUpdate:@"insert into JpushNews values(?,?,?,?,?)",dic[@"time"],dic[@"content"],dic[@"NewsID"],dic[@"DocID"],dic[@"state"]];
}

//查询 推送 是否有 新消息
-(NSArray*)IsSelectNewsData
{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    FMResultSet * result=[fm executeQuery:@"select * from JpushNews WHERE DocID = ?",[user objectForKey:doc_id]];
    NSMutableArray * array=[NSMutableArray arrayWithCapacity:0];
    while ([result next]) {
        JpushNewsModel * model=[[JpushNewsModel alloc]init];
        
        if (![PublicFunction isBlankString:[result stringForColumn:@"content"]]) {

            if ([[result stringForColumn:@"state"] intValue]==0) {
                [array addObject:model];
            }
        }
    }
    return array;
}

//查询 推送
-(NSArray *)selectNewsData
{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    FMResultSet * result=[fm executeQuery:@"select * from JpushNews WHERE DocID = ?",[user objectForKey:doc_id]];
    NSMutableArray * array=[NSMutableArray arrayWithCapacity:0];
    while ([result next]) {
        JpushNewsModel * model=[[JpushNewsModel alloc]init];
        
        if (![PublicFunction isBlankString:[result stringForColumn:@"content"]]) {
            model.time=[result stringForColumn:@"time"];
            model.content=[result stringForColumn:@"content"];
            model.NewsID=[result stringForColumn:@"NewsID"];
            model.state=[result stringForColumn:@"state"];
            [array addObject:model];
        }
    }
    return array;
}

//修改 推送 查看状态
-(void)updateNewsDataByNewsID:(NSString*)NewsID Time:(NSString*)Time
{
    if ([self isTableOK:@"JpushNews"]) {
        
        [fm executeUpdate:@"update JpushNews SET state = ? where NewsID = ? and time = ?",@"1", NewsID,Time];
    }
}

//删除 推送
-(void)deleteNewsDataByNewsID:(NSString*)NewsID Time:(NSString*)Time
{
    if ([self isTableOK:@"JpushNews"]) {
        
        [fm executeUpdate:@"delete from JpushNews where NewsID = ? and time = ?", NewsID,Time];
        
        if ([self isTableOK:@"JpushReply"]) {
            
            [fm executeUpdate:@"delete from JpushReply where NewsID = ?", NewsID];
        }
    }
}






//添加 回复
-(BOOL)addReplyData:(NSDictionary*)dic
{
    return [fm executeUpdate:@"insert into JpushReply values(?,?,?)",dic[@"time"],dic[@"content"],dic[@"NewsID"]];
}


//查询 回复
-(NSArray *)selectReplyData:(NSString*)NewsID
{
    FMResultSet * result=[fm executeQuery:@"select * from JpushReply where NewsID = ?", NewsID];
    NSMutableArray * array=[NSMutableArray arrayWithCapacity:0];
    while ([result next]) {
        JpushReplyModel * model=[[JpushReplyModel alloc]init];
        
        if (![PublicFunction isBlankString:[result stringForColumn:@"content"]]) {
            model.time=[result stringForColumn:@"time"];
            model.content=[result stringForColumn:@"content"];
            model.NewsID=[result stringForColumn:@"NewsID"];
            [array addObject:model];
        }
    }
    
    return array;
}





/*
//添加 采集各个小项状态
-(void)addCollectionData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into Collection values(?,?,?,?,?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"yongHuQZ"],dict[@"shenFenXX"],dict[@"geRenXX"],dict[@"jianHuRenXX"],dict[@"jinJiLX"],dict[@"muQianZK"],dict[@"yiQueZhenJB"],dict[@"jiaTingZH"],dict[@"waiBuTG"],dict[@"xinXiCJ"],dict[@"juJiaZH"]];
}

//修改 采集各个小项状态
-(void)updateCollectionByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update Collection SET yongHuQZ = ? where shenFenZJ = ?",dict[@"yongHuQZ"], shenFenZJ];
    [fm executeUpdate:@"update Collection SET shenFenXX = ? where shenFenZJ = ?",dict[@"shenFenXX"], shenFenZJ];
    
    [fm executeUpdate:@"update Collection SET geRenXX = ? where shenFenZJ = ?",dict[@"geRenXX"], shenFenZJ];
    [fm executeUpdate:@"update Collection SET jianHuRenXX = ? where shenFenZJ = ?",dict[@"jianHuRenXX"], shenFenZJ];
    
    [fm executeUpdate:@"update Collection SET jinJiLX = ? where shenFenZJ = ?",dict[@"jinJiLX"], shenFenZJ];
    [fm executeUpdate:@"update Collection SET muQianZK = ? where shenFenZJ = ?",dict[@"muQianZK"], shenFenZJ];
    
    [fm executeUpdate:@"update Collection SET yiQueZhenJB = ? where shenFenZJ = ?",dict[@"yiQueZhenJB"], shenFenZJ];
    [fm executeUpdate:@"update Collection SET jiaTingZH = ? where shenFenZJ = ?",dict[@"jiaTingZH"], shenFenZJ];
    
    [fm executeUpdate:@"update Collection SET waiBuTG = ? where shenFenZJ = ?",dict[@"waiBuTG"], shenFenZJ];
    [fm executeUpdate:@"update Collection SET xinXiCJ = ? where shenFenZJ = ?",dict[@"xinXiCJ"], shenFenZJ];
    
    [fm executeUpdate:@"update Collection SET juJiaZH = ? where shenFenZJ = ?",dict[@"juJiaZH"], shenFenZJ];
}

//查询 采集各个小项状态
-(NSArray *)selectCollectionByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from Collection WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        CollectModel * model=[[CollectModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"shenFenZJ"];
        
        model.yongHuQZ=[result stringForColumn:@"yongHuQZ"];
        model.shenFenXX=[result stringForColumn:@"shenFenXX"];
        
        model.geRenXX=[result stringForColumn:@"geRenXX"];
        model.jianHuRenXX=[result stringForColumn:@"jianHuRenXX"];
        
        model.jinJiLX=[result stringForColumn:@"jinJiLX"];
        model.muQianZK=[result stringForColumn:@"muQianZK"];
        
        model.jiaTingZH=[result stringForColumn:@"jiaTingZH"];
        model.waiBuTG=[result stringForColumn:@"waiBuTG"];
        
        model.xinXiCJ=[result stringForColumn:@"xinXiCJ"];
        model.juJiaZH=[result stringForColumn:@"juJiaZH"];
        
        [array addObject:model];
    }
    return array;
}












//添加 用户签字
-(void)addYongHuQZData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into YongHuQZ values(?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"agree1"],dict[@"agree2"],dict[@"agree3"],dict[@"qianMing"]];
}

//修改 用户签字
-(void)updateYongHuQZByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update YongHuQZ SET qianMing = ? where shenFenZJ = ?",dict[@"qianMing"], shenFenZJ];
}

//查询 用户签字
-(NSArray *)selectYongHuQZByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from YongHuQZ WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        ShenFenXXModel * model=[[ShenFenXXModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"shenFenZJ"];
        model.agree1=[result stringForColumn:@"agree1"];
        model.agree2=[result stringForColumn:@"agree2"];
        model.agree3=[result stringForColumn:@"agree3"];
        model.qianMing=[result stringForColumn:@"qianMing"];
        
        [array addObject:model];
    }
    return array;
}

//删除 用户签字
-(void)deleteYongHuQZByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from YongHuQZ where shenFenZJ = ?", shenFenZJ];
}





//添加 身份信息
-(void)addShenFenXXData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into ShenFenXX values(?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"xingMing"],dict[@"yiBaoKH"],dict[@"canJiJR"],dict[@"canJiRZ"]];
}

//修改 身份信息
-(void)updateShenFenXXByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update ShenFenXX SET yiBaoKH = ? where shenFenZJ = ?",dict[@"yiBaoKH"],shenFenZJ];
    [fm executeUpdate:@"update ShenFenXX SET canJiJR = ? where shenFenZJ = ?",dict[@"canJiJR"],shenFenZJ];
    [fm executeUpdate:@"update ShenFenXX SET canJiRZ = ? where shenFenZJ = ?",dict[@"canJiRZ"],shenFenZJ];
}

//查询 身份信息
-(NSArray *)selectShenFenXXByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from ShenFenXX WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        ShenFenXXModel * model=[[ShenFenXXModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"shenFenZJ"];
        model.xingMing=[result stringForColumn:@"xingMing"];
        model.yiBaoKH=[result stringForColumn:@"yiBaoKH"];
        model.canJiJR=[result stringForColumn:@"canJiJR"];
        model.canJiRZ=[result stringForColumn:@"canJiRZ"];
        
        [array addObject:model];
    }
    return array;
}

//删除 身份信息
-(void)deleteShenFenXXByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from ShenFenXX where shenFenZJ = ?", shenFenZJ];
}






//添加 个人信息
-(void)addGeRenXXData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into GeRenXX values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"xingBie"],dict[@"chuShengRQ"],dict[@"minZu"],dict[@"zhongJiaoXY"],dict[@"hunYinZK"],dict[@"wenHuaCD"],dict[@"jiGuanSheng"],dict[@"jiGuanShi"],dict[@"shiYongYY"],dict[@"huJiSheng"],dict[@"huJiShi"],dict[@"huJiQu"],dict[@"huJiJie"],dict[@"huJiSheQu"],dict[@"huJiAddress"],dict[@"juZhuSheng"],dict[@"juZhuShi"],dict[@"juZhuQu"],dict[@"juZhuJie"],dict[@"juZhuSheQu"],dict[@"juZhuAddress"],dict[@"zhuZhaiDH"],dict[@"yiDongDH"],dict[@"youZhengBM"],dict[@"dianZiYX"]];
}

//修改 个人信息
-(void)updateGeRenXXByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update GeRenXX SET xingBie = ? where shenFenZJ = ?",dict[@"xingBie"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET chuShengRQ = ? where shenFenZJ = ?",dict[@"chuShengRQ"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET minZu = ? where shenFenZJ = ?",dict[@"minZu"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET zhongJiaoXY = ? where shenFenZJ = ?",dict[@"zhongJiaoXY"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET hunYinZK = ? where shenFenZJ = ?",dict[@"hunYinZK"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET wenHuaCD = ? where shenFenZJ = ?",dict[@"wenHuaCD"],shenFenZJ];
    
    [fm executeUpdate:@"update GeRenXX SET jiGuanSheng = ? where shenFenZJ = ?",dict[@"jiGuanSheng"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET jiGuanShi = ? where shenFenZJ = ?",dict[@"jiGuanShi"],shenFenZJ];
    
    [fm executeUpdate:@"update GeRenXX SET shiYongYY = ? where shenFenZJ = ?",dict[@"shiYongYY"],shenFenZJ];
    
    [fm executeUpdate:@"update GeRenXX SET huJiSheng = ? where shenFenZJ = ?",dict[@"huJiSheng"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET huJiShi = ? where shenFenZJ = ?",dict[@"huJiShi"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET huJiQu = ? where shenFenZJ = ?",dict[@"huJiQu"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET huJiJie = ? where shenFenZJ = ?",dict[@"huJiJie"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET huJiSheQu = ? where shenFenZJ = ?",dict[@"huJiSheQu"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET huJiAddress = ? where shenFenZJ = ?",dict[@"huJiAddress"],shenFenZJ];
    
    [fm executeUpdate:@"update GeRenXX SET juZhuSheng = ? where shenFenZJ = ?",dict[@"juZhuSheng"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET juZhuShi = ? where shenFenZJ = ?",dict[@"juZhuShi"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET juZhuQu = ? where shenFenZJ = ?",dict[@"juZhuQu"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET juZhuJie = ? where shenFenZJ = ?",dict[@"juZhuJie"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET juZhuSheQu = ? where shenFenZJ = ?",dict[@"juZhuSheQu"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET juZhuAddress = ? where shenFenZJ = ?",dict[@"juZhuAddress"],shenFenZJ];
    
    [fm executeUpdate:@"update GeRenXX SET zhuZhaiDH = ? where shenFenZJ = ?",dict[@"zhuZhaiDH"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET yiDongDH = ? where shenFenZJ = ?",dict[@"yiDongDH"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET youZhengBM = ? where shenFenZJ = ?",dict[@"youZhengBM"],shenFenZJ];
    [fm executeUpdate:@"update GeRenXX SET dianZiYX = ? where shenFenZJ = ?",dict[@"dianZiYX"],shenFenZJ];
}

//查询 个人信息
-(NSArray *)selectGeRenXXByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from GeRenXX WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        GeRenXXModel * model=[[GeRenXXModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"shenFenZJ"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.xingBie=[result stringForColumn:@"xingBie"];
        model.chuShengRQ=[result stringForColumn:@"chuShengRQ"];
        model.minZu=[result stringForColumn:@"minZu"];
        model.zhongJiaoXY=[result stringForColumn:@"zhongJiaoXY"];
        model.hunYinZK=[result stringForColumn:@"hunYinZK"];
        model.wenHuaCD=[result stringForColumn:@"wenHuaCD"];
        
        model.jiGuanSheng=[result stringForColumn:@"jiGuanSheng"];
        model.jiGuanShi=[result stringForColumn:@"jiGuanShi"];
        
        model.shiYongYY=[result stringForColumn:@"shiYongYY"];
        
        model.huJiSheng=[result stringForColumn:@"huJiSheng"];
        model.huJiShi=[result stringForColumn:@"huJiShi"];
        model.huJiQu=[result stringForColumn:@"huJiQu"];
        model.huJiJie=[result stringForColumn:@"huJiJie"];
        model.huJiSheQu=[result stringForColumn:@"huJiSheQu"];
        model.huJiAddress=[result stringForColumn:@"huJiAddress"];
        
        model.juZhuSheng=[result stringForColumn:@"juZhuSheng"];
        model.juZhuShi=[result stringForColumn:@"juZhuShi"];
        model.juZhuQu=[result stringForColumn:@"juZhuQu"];
        model.juZhuJie=[result stringForColumn:@"juZhuJie"];
        model.juZhuSheQu=[result stringForColumn:@"juZhuSheQu"];
        model.juZhuAddress=[result stringForColumn:@"juZhuAddress"];
        
        model.zhuZhaiDH=[result stringForColumn:@"zhuZhaiDH"];
        model.yiDongDH=[result stringForColumn:@"yiDongDH"];
        model.youZhengBM=[result stringForColumn:@"youZhengBM"];
        model.dianZiYX=[result stringForColumn:@"dianZiYX"];
        
        [array addObject:model];
    }
    return array;
}

//删除 个人信息
-(void)deleteGeRenXXByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from GeRenXX where shenFenZJ = ?", shenFenZJ];
}





//添加 监护人信息
-(void)addJianHuRenXXData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into JianHuRenXX values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"jianHuRX"],dict[@"yuLaoRG"],dict[@"juZhuSheng"],dict[@"juZhuShi"],dict[@"juZhuQu"],dict[@"juZhuJie"],dict[@"juZhuSheQu"],dict[@"juZhuAddress"],dict[@"zhuZhaiDH"],dict[@"yiDongDH"],dict[@"youZhengBM"],dict[@"dianZiYX"]];
}

//修改 监护人信息
-(void)updateJianHuRenXXByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update JianHuRenXX SET jianHuRX = ? where shenFenZJ = ?",dict[@"jianHuRX"],shenFenZJ];
    [fm executeUpdate:@"update JianHuRenXX SET yuLaoRG = ? where shenFenZJ = ?",dict[@"yuLaoRG"],shenFenZJ];
    
    [fm executeUpdate:@"update JianHuRenXX SET juZhuSheng = ? where shenFenZJ = ?",dict[@"juZhuSheng"],shenFenZJ];
    [fm executeUpdate:@"update JianHuRenXX SET juZhuShi = ? where shenFenZJ = ?",dict[@"juZhuShi"],shenFenZJ];
    [fm executeUpdate:@"update JianHuRenXX SET juZhuQu = ? where shenFenZJ = ?",dict[@"juZhuQu"],shenFenZJ];
    [fm executeUpdate:@"update JianHuRenXX SET juZhuJie = ? where shenFenZJ = ?",dict[@"juZhuJie"],shenFenZJ];
    [fm executeUpdate:@"update JianHuRenXX SET juZhuSheQu = ? where shenFenZJ = ?",dict[@"juZhuSheQu"],shenFenZJ];
    [fm executeUpdate:@"update JianHuRenXX SET juZhuAddress = ? where shenFenZJ = ?",dict[@"juZhuAddress"],shenFenZJ];
    
    [fm executeUpdate:@"update JianHuRenXX SET zhuZhaiDH = ? where shenFenZJ = ?",dict[@"zhuZhaiDH"],shenFenZJ];
    [fm executeUpdate:@"update JianHuRenXX SET yiDongDH = ? where shenFenZJ = ?",dict[@"yiDongDH"],shenFenZJ];
    [fm executeUpdate:@"update JianHuRenXX SET youZhengBM = ? where shenFenZJ = ?",dict[@"youZhengBM"],shenFenZJ];
    [fm executeUpdate:@"update JianHuRenXX SET dianZiYX = ? where shenFenZJ = ?",dict[@"dianZiYX"],shenFenZJ];
    
}

//查询 监护人信息
-(NSArray*)selectJianHuRenXXByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from JianHuRenXX WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        JianHuRenXXModel * model=[[JianHuRenXXModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"shenFenZJ"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.jianHuRX=[result stringForColumn:@"jianHuRX"];
        model.yuLaoRG=[result stringForColumn:@"yuLaoRG"];
        
        model.juZhuSheng=[result stringForColumn:@"juZhuSheng"];
        model.juZhuShi=[result stringForColumn:@"juZhuShi"];
        model.juZhuQu=[result stringForColumn:@"juZhuQu"];
        model.juZhuJie=[result stringForColumn:@"juZhuJie"];
        model.juZhuSheQu=[result stringForColumn:@"juZhuSheQu"];
        model.juZhuAddress=[result stringForColumn:@"juZhuAddress"];
        
        model.zhuZhaiDH=[result stringForColumn:@"zhuZhaiDH"];
        model.yiDongDH=[result stringForColumn:@"yiDongDH"];
        model.youZhengBM=[result stringForColumn:@"youZhengBM"];
        model.dianZiYX=[result stringForColumn:@"dianZiYX"];
        
        [array addObject:model];
    }
    return array;
}

//删除 监护人信息
-(void)deleteJianHuRenXXByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from JianHuRenXX where shenFenZJ = ?", shenFenZJ];
}







//添加 紧急联系人
-(void)addJinJiLXData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into JinJiLX values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"jianHuRX"],dict[@"yuLaoRG"],dict[@"juZhuSheng"],dict[@"juZhuShi"],dict[@"juZhuQu"],dict[@"juZhuJie"],dict[@"juZhuSheQu"],dict[@"juZhuAddress"],dict[@"zhuZhaiDH"],dict[@"yiDongDH"],dict[@"youZhengBM"],dict[@"dianZiYX"]];
}

//修改 紧急联系人
-(void)updateJinJiLXByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update JinJiLX SET jianHuRX = ? where shenFenZJ = ?",dict[@"jianHuRX"],shenFenZJ];
    [fm executeUpdate:@"update JinJiLX SET yuLaoRG = ? where shenFenZJ = ?",dict[@"yuLaoRG"],shenFenZJ];
    
    [fm executeUpdate:@"update JinJiLX SET juZhuSheng = ? where shenFenZJ = ?",dict[@"juZhuSheng"],shenFenZJ];
    [fm executeUpdate:@"update JinJiLX SET juZhuShi = ? where shenFenZJ = ?",dict[@"juZhuShi"],shenFenZJ];
    [fm executeUpdate:@"update JinJiLX SET juZhuQu = ? where shenFenZJ = ?",dict[@"juZhuQu"],shenFenZJ];
    [fm executeUpdate:@"update JinJiLX SET juZhuJie = ? where shenFenZJ = ?",dict[@"juZhuJie"],shenFenZJ];
    [fm executeUpdate:@"update JinJiLX SET juZhuSheQu = ? where shenFenZJ = ?",dict[@"juZhuSheQu"],shenFenZJ];
    [fm executeUpdate:@"update JinJiLX SET juZhuAddress = ? where shenFenZJ = ?",dict[@"juZhuAddress"],shenFenZJ];
    
    [fm executeUpdate:@"update JinJiLX SET zhuZhaiDH = ? where shenFenZJ = ?",dict[@"zhuZhaiDH"],shenFenZJ];
    [fm executeUpdate:@"update JinJiLX SET yiDongDH = ? where shenFenZJ = ?",dict[@"yiDongDH"],shenFenZJ];
    [fm executeUpdate:@"update JinJiLX SET youZhengBM = ? where shenFenZJ = ?",dict[@"youZhengBM"],shenFenZJ];
    [fm executeUpdate:@"update JinJiLX SET dianZiYX = ? where shenFenZJ = ?",dict[@"dianZiYX"],shenFenZJ];
    
}

//查询 紧急联系人
-(NSArray*)selectJinJiLXByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from JinJiLX WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        JianHuRenXXModel * model=[[JianHuRenXXModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"shenFenZJ"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.jianHuRX=[result stringForColumn:@"jianHuRX"];
        model.yuLaoRG=[result stringForColumn:@"yuLaoRG"];
        
        model.juZhuSheng=[result stringForColumn:@"juZhuSheng"];
        model.juZhuShi=[result stringForColumn:@"juZhuShi"];
        model.juZhuQu=[result stringForColumn:@"juZhuQu"];
        model.juZhuJie=[result stringForColumn:@"juZhuJie"];
        model.juZhuSheQu=[result stringForColumn:@"juZhuSheQu"];
        model.juZhuAddress=[result stringForColumn:@"juZhuAddress"];
        
        model.zhuZhaiDH=[result stringForColumn:@"zhuZhaiDH"];
        model.yiDongDH=[result stringForColumn:@"yiDongDH"];
        model.youZhengBM=[result stringForColumn:@"youZhengBM"];
        model.dianZiYX=[result stringForColumn:@"dianZiYX"];
        
        [array addObject:model];
    }
    return array;
}

//删除 紧急联系人
-(void)deleteJinJiLXByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from JinJiLX where shenFenZJ = ?", shenFenZJ];
}








//添加 目前生活状况
-(void)addMuQianZKData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into MuQianZK values(?,?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"juZhuQK"],dict[@"jingJiLY"],dict[@"tongZhuPO"],dict[@"ziJinKN"],dict[@"juZhuHJ"],dict[@"yiLiaoZF"],dict[@"qiTaZK"]];
}

//修改 目前生活状况
-(void)updateMuQianZKByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update MuQianZK SET juZhuQK = ? where shenFenZJ = ?",dict[@"juZhuQK"],shenFenZJ];
    [fm executeUpdate:@"update MuQianZK SET jingJiLY = ? where shenFenZJ = ?",dict[@"jingJiLY"],shenFenZJ];
    [fm executeUpdate:@"update MuQianZK SET tongZhuPO = ? where shenFenZJ = ?",dict[@"tongZhuPO"],shenFenZJ];
    [fm executeUpdate:@"update MuQianZK SET ziJinKN = ? where shenFenZJ = ?",dict[@"ziJinKN"],shenFenZJ];
    [fm executeUpdate:@"update MuQianZK SET juZhuHJ = ? where shenFenZJ = ?",dict[@"juZhuHJ"],shenFenZJ];
    
    
    [fm executeUpdate:@"update MuQianZK SET yiLiaoZF = ? where shenFenZJ = ?",dict[@"yiLiaoZF"],shenFenZJ];
    [fm executeUpdate:@"update MuQianZK SET qiTaZK = ? where shenFenZJ = ?",dict[@"qiTaZK"],shenFenZJ];
    
}

//查询 目前生活状况
-(NSArray*)selectMuQianZKByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from MuQianZK WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        MuQianZKModel * model=[[MuQianZKModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"shenFenZJ"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.juZhuQK=[result stringForColumn:@"juZhuQK"];
        model.jingJiLY=[result stringForColumn:@"jingJiLY"];
        model.tongZhuPO=[result stringForColumn:@"tongZhuPO"];
        model.ziJinKN=[result stringForColumn:@"ziJinKN"];
        
        model.juZhuHJ=[result stringForColumn:@"juZhuHJ"];
        model.yiLiaoZF=[result stringForColumn:@"yiLiaoZF"];
        model.qiTaZK=[result stringForColumn:@"qiTaZK"];
    
        [array addObject:model];
    }
    return array;
}

//删除 目前生活状况
-(void)deleteMuQianZKByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from MuQianZK where shenFenZJ = ?", shenFenZJ];
}






//添加 已确诊疾病
-(void)addYiQueZhenJBData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into YiQueZhenJB values(?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"chuanRanJB"],dict[@"fengXianGW"],dict[@"yinShiXZ"],dict[@"qiTaJB"]];
}

//修改 已确诊疾病
-(void)updateYiQueZhenJBByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update YiQueZhenJB SET chuanRanJB = ? where shenFenZJ = ?",dict[@"chuanRanJB"],shenFenZJ];
    [fm executeUpdate:@"update YiQueZhenJB SET fengXianGW = ? where shenFenZJ = ?",dict[@"fengXianGW"],shenFenZJ];

    [fm executeUpdate:@"update YiQueZhenJB SET yinShiXZ = ? where shenFenZJ = ?",dict[@"yinShiXZ"],shenFenZJ];
    [fm executeUpdate:@"update YiQueZhenJB SET qiTaJB = ? where shenFenZJ = ?",dict[@"qiTaJB"],shenFenZJ];
    
}

//查询 已确诊疾病
-(NSArray*)selectYiQueZhenJBByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from YiQueZhenJB WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        YiQueZhenJBModel * model=[[YiQueZhenJBModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.chuanRanJB=[result stringForColumn:@"chuanRanJB"];
        model.fengXianGW=[result stringForColumn:@"fengXianGW"];
        model.yinShiXZ=[result stringForColumn:@"yinShiXZ"];
        model.qiTaJB=[result stringForColumn:@"qiTaJB"];
        
        [array addObject:model];
    }
    return array;
}

//删除 已确诊疾病
-(void)deleteYiQueZhenJBByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from YiQueZhenJB where shenFenZJ = ?", shenFenZJ];
}








//添加 家庭主要照护者信息
-(void)addJiaTingZHData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into JiaTingZH values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"xingMing"],dict[@"nianLing"],dict[@"xingBie"],dict[@"yuLaoRG"],dict[@"juZhuSheng"],dict[@"juZhuShi"],dict[@"juZhuQu"],dict[@"juZhuJie"],dict[@"juZhuSheQu"],dict[@"juZhuAddress"],dict[@"yuLaoRT"],dict[@"youZhengBM"],dict[@"zhuZhaiDH"],dict[@"yiDongDH"],dict[@"dianZiYX"],dict[@"jiaTingZHZT"],dict[@"jiaTingCY5H"],dict[@"jiaTingCY5M"],dict[@"jiaTingCY2H"],dict[@"jiaTingCY2M"],dict[@"jiaTingZHRY"]];
}

//修改 家庭主要照护者信息
-(void)updateJiaTingZHByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update JiaTingZH SET xingMing = ? where shenFenZJ = ?",dict[@"xingMing"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingZH SET nianLing = ? where shenFenZJ = ?",dict[@"nianLing"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingZH SET xingBie = ? where shenFenZJ = ?",dict[@"xingBie"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingZH SET yuLaoRG = ? where shenFenZJ = ?",dict[@"yuLaoRG"],shenFenZJ];
    
    [fm executeUpdate:@"update JiaTingZH SET juZhuSheng = ? where shenFenZJ = ?",dict[@"juZhuSheng"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingZH SET juZhuShi = ? where shenFenZJ = ?",dict[@"juZhuShi"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingZH SET juZhuQu = ? where shenFenZJ = ?",dict[@"juZhuQu"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingZH SET juZhuJie = ? where shenFenZJ = ?",dict[@"juZhuJie"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingZH SET juZhuSheQu = ? where shenFenZJ = ?",dict[@"juZhuSheQu"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingZH SET juZhuAddress = ? where shenFenZJ = ?",dict[@"juZhuAddress"],shenFenZJ];
    
    
    [fm executeUpdate:@"update JiaTingZH SET yuLaoRT = ? where shenFenZJ = ?",dict[@"yuLaoRT"],shenFenZJ];
    
    [fm executeUpdate:@"update JiaTingZH SET youZhengBM = ? where shenFenZJ = ?",dict[@"youZhengBM"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingZH SET zhuZhaiDH = ? where shenFenZJ = ?",dict[@"zhuZhaiDH"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingZH SET yiDongDH = ? where shenFenZJ = ?",dict[@"yiDongDH"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingZH SET dianZiYX = ? where shenFenZJ = ?",dict[@"dianZiYX"],shenFenZJ];
    
    [fm executeUpdate:@"update JiaTingZH SET jiaTingZHZT = ? where shenFenZJ = ?",dict[@"jiaTingZHZT"],shenFenZJ];
    
    [fm executeUpdate:@"update JiaTingZH SET jiaTingCY5H = ? where shenFenZJ = ?",dict[@"jiaTingCY5H"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingZH SET jiaTingCY5M = ? where shenFenZJ = ?",dict[@"jiaTingCY5M"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingZH SET jiaTingCY2H = ? where shenFenZJ = ?",dict[@"jiaTingCY2H"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingZH SET jiaTingCY2M = ? where shenFenZJ = ?",dict[@"jiaTingCY2M"],shenFenZJ];
    
    [fm executeUpdate:@"update JiaTingZH SET jiaTingZHRY = ? where shenFenZJ = ?",dict[@"jiaTingZHRY"],shenFenZJ];
}

//查询 家庭主要照护者信息
-(NSArray*)selectJiaTingZHByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from JiaTingZH WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        JiaTingZHModel * model=[[JiaTingZHModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.xingMing=[result stringForColumn:@"xingMing"];
        model.nianLing=[result stringForColumn:@"nianLing"];
        model.xingBie=[result stringForColumn:@"xingBie"];
        model.yuLaoRG=[result stringForColumn:@"yuLaoRG"];
        
        model.juZhuSheng=[result stringForColumn:@"juZhuSheng"];
        model.juZhuShi=[result stringForColumn:@"juZhuShi"];
        model.juZhuQu=[result stringForColumn:@"juZhuQu"];
        model.juZhuJie=[result stringForColumn:@"juZhuJie"];
        model.juZhuSheQu=[result stringForColumn:@"juZhuSheQu"];
        model.juZhuAddress=[result stringForColumn:@"juZhuAddress"];
        
        model.yuLaoRT=[result stringForColumn:@"yuLaoRT"];
        
        model.youZhengBM=[result stringForColumn:@"youZhengBM"];
        model.zhuZhaiDH=[result stringForColumn:@"zhuZhaiDH"];
        model.yiDongDH=[result stringForColumn:@"yiDongDH"];
        model.dianZiYX=[result stringForColumn:@"dianZiYX"];
        
        model.jiaTingZHZT=[result stringForColumn:@"jiaTingZHZT"];
        
        model.jiaTingCY5H=[result stringForColumn:@"jiaTingCY5H"];
        model.jiaTingCY5M=[result stringForColumn:@"jiaTingCY5M"];
        model.jiaTingCY2H=[result stringForColumn:@"jiaTingCY2H"];
        model.jiaTingCY2M=[result stringForColumn:@"jiaTingCY2M"];
        
        model.jiaTingZHRY=[result stringForColumn:@"jiaTingZHRY"];
        
        [array addObject:model];
    }
    return array;
}

//删除 家庭主要照护者信息
-(void)deleteJiaTingZHByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from JiaTingZH where shenFenZJ = ?", shenFenZJ];
}









//添加 外部提供的专业看护服务
-(void)addWaiBuTGData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into WaiBuTG values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"guWenHQD"],dict[@"guWenHQH"],dict[@"guWenHQM"],dict[@"geRenSSD"],dict[@"geRenSSH"],dict[@"geRenSSM"],dict[@"juJiaSSD"],dict[@"juJiaSSH"],dict[@"juJiaSSM"],dict[@"kanHuMB"],dict[@"kanHuXQ"]];
}

//修改 外部提供的专业看护服务
-(void)updateWaiBuTGByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update WaiBuTG SET guWenHQD = ? where shenFenZJ = ?",dict[@"guWenHQD"],shenFenZJ];
    [fm executeUpdate:@"update WaiBuTG SET guWenHQH = ? where shenFenZJ = ?",dict[@"guWenHQH"],shenFenZJ];
    [fm executeUpdate:@"update WaiBuTG SET guWenHQM = ? where shenFenZJ = ?",dict[@"guWenHQM"],shenFenZJ];
    
    [fm executeUpdate:@"update WaiBuTG SET geRenSSD = ? where shenFenZJ = ?",dict[@"geRenSSD"],shenFenZJ];
    [fm executeUpdate:@"update WaiBuTG SET geRenSSH = ? where shenFenZJ = ?",dict[@"geRenSSH"],shenFenZJ];
    [fm executeUpdate:@"update WaiBuTG SET geRenSSM = ? where shenFenZJ = ?",dict[@"geRenSSM"],shenFenZJ];
    
    [fm executeUpdate:@"update WaiBuTG SET juJiaSSD = ? where shenFenZJ = ?",dict[@"juJiaSSD"],shenFenZJ];
    [fm executeUpdate:@"update WaiBuTG SET juJiaSSH = ? where shenFenZJ = ?",dict[@"juJiaSSH"],shenFenZJ];
    [fm executeUpdate:@"update WaiBuTG SET juJiaSSM = ? where shenFenZJ = ?",dict[@"juJiaSSM"],shenFenZJ];
    
    [fm executeUpdate:@"update WaiBuTG SET kanHuMB = ? where shenFenZJ = ?",dict[@"kanHuMB"],shenFenZJ];
    [fm executeUpdate:@"update WaiBuTG SET kanHuXQ = ? where shenFenZJ = ?",dict[@"kanHuXQ"],shenFenZJ];
    
}

//查询 外部提供的专业看护服务
-(NSArray*)selectWaiBuTGByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from WaiBuTG WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        WaiBuTGModel * model=[[WaiBuTGModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.guWenHQD=[result stringForColumn:@"guWenHQD"];
        model.guWenHQH=[result stringForColumn:@"guWenHQH"];
        model.guWenHQM=[result stringForColumn:@"guWenHQM"];
        
        model.geRenSSD=[result stringForColumn:@"geRenSSD"];
        model.geRenSSH=[result stringForColumn:@"geRenSSH"];
        model.geRenSSM=[result stringForColumn:@"geRenSSM"];
        
        model.juJiaSSD=[result stringForColumn:@"juJiaSSD"];
        model.juJiaSSH=[result stringForColumn:@"juJiaSSH"];
        model.juJiaSSM=[result stringForColumn:@"juJiaSSM"];
        
        model.kanHuMB=[result stringForColumn:@"kanHuMB"];
        model.kanHuXQ=[result stringForColumn:@"kanHuXQ"];
        
        [array addObject:model];
    }
    return array;
}

//删除 外部提供的专业看护服务
-(void)deleteWaiBuTGByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from WaiBuTG where shenFenZJ = ?", shenFenZJ];
}






//添加 信息采集初步结果
-(void)addXinXiCJData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into XinXiCJ values(?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"chuBuYX"],dict[@"chuPingJY"]];
}

//修改 信息采集初步结果
-(void)updateXinXiCJByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update XinXiCJ SET chuBuYX = ? where shenFenZJ = ?",dict[@"chuBuYX"],shenFenZJ];
    [fm executeUpdate:@"update XinXiCJ SET chuPingJY = ? where shenFenZJ = ?",dict[@"chuPingJY"],shenFenZJ];
    
}

//查询 信息采集初步结果
-(NSArray*)selectXinXiCJByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from XinXiCJ WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        XinXiCJModel * model=[[XinXiCJModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.chuBuYX=[result stringForColumn:@"chuBuYX"];
        model.chuPingJY=[result stringForColumn:@"chuPingJY"];

        
        [array addObject:model];
    }
    return array;
}

//删除 信息采集初步结果
-(void)deleteXinXiCJByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from XinXiCJ where shenFenZJ = ?", shenFenZJ];
}







//添加 居家照护管理员
-(void)addJuJiaZHData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into JuJiaZH values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"xingMing"],dict[@"suoShuJG"],dict[@"juZhuSheng"],dict[@"juZhuShi"],dict[@"juZhuQu"],dict[@"juZhuJie"],dict[@"juZhuSheQu"],dict[@"juZhuAddress"],dict[@"zhuZhaiDH"],dict[@"yiDongDH"],dict[@"youZhengBM"],dict[@"dianZiYX"]];
}

//修改 居家照护管理员
-(void)updateJuJiaZHByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update JuJiaZH SET xingMing = ? where shenFenZJ = ?",dict[@"xingMing"],shenFenZJ];
    [fm executeUpdate:@"update JuJiaZH SET suoShuJG = ? where shenFenZJ = ?",dict[@"suoShuJG"],shenFenZJ];
    
    [fm executeUpdate:@"update JuJiaZH SET juZhuSheng = ? where shenFenZJ = ?",dict[@"juZhuSheng"],shenFenZJ];
    [fm executeUpdate:@"update JuJiaZH SET juZhuShi = ? where shenFenZJ = ?",dict[@"juZhuShi"],shenFenZJ];
    [fm executeUpdate:@"update JuJiaZH SET juZhuQu = ? where shenFenZJ = ?",dict[@"juZhuQu"],shenFenZJ];
    [fm executeUpdate:@"update JuJiaZH SET juZhuJie = ? where shenFenZJ = ?",dict[@"juZhuJie"],shenFenZJ];
    [fm executeUpdate:@"update JuJiaZH SET juZhuSheQu = ? where shenFenZJ = ?",dict[@"juZhuSheQu"],shenFenZJ];
    [fm executeUpdate:@"update JuJiaZH SET juZhuAddress = ? where shenFenZJ = ?",dict[@"juZhuAddress"],shenFenZJ];
    
    [fm executeUpdate:@"update JuJiaZH SET zhuZhaiDH = ? where shenFenZJ = ?",dict[@"zhuZhaiDH"],shenFenZJ];
    [fm executeUpdate:@"update JuJiaZH SET yiDongDH = ? where shenFenZJ = ?",dict[@"yiDongDH"],shenFenZJ];
    [fm executeUpdate:@"update JuJiaZH SET youZhengBM = ? where shenFenZJ = ?",dict[@"youZhengBM"],shenFenZJ];
    [fm executeUpdate:@"update JuJiaZH SET dianZiYX = ? where shenFenZJ = ?",dict[@"dianZiYX"],shenFenZJ];
    
}

//查询 居家照护管理员
-(NSArray*)selectJuJiaZHByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from JuJiaZH WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        JuJiaZHModel * model=[[JuJiaZHModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.xingMing=[result stringForColumn:@"xingMing"];
        model.suoShuJG=[result stringForColumn:@"suoShuJG"];
        
        model.juZhuSheng=[result stringForColumn:@"juZhuSheng"];
        model.juZhuShi=[result stringForColumn:@"juZhuShi"];
        model.juZhuQu=[result stringForColumn:@"juZhuQu"];
        model.juZhuJie=[result stringForColumn:@"juZhuJie"];
        model.juZhuSheQu=[result stringForColumn:@"juZhuSheQu"];
        model.juZhuAddress=[result stringForColumn:@"juZhuAddress"];
        
        model.zhuZhaiDH=[result stringForColumn:@"zhuZhaiDH"];
        model.yiDongDH=[result stringForColumn:@"yiDongDH"];
        model.youZhengBM=[result stringForColumn:@"youZhengBM"];
        model.dianZiYX=[result stringForColumn:@"dianZiYX"];
        
        [array addObject:model];
    }
    return array;
}

//删除 居家照护管理员
-(void)deleteJuJiaZHByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from JuJiaZH where shenFenZJ = ?", shenFenZJ];
}








//添加 评估基本信息
-(void)addPingGuJBData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into PingGuJB values(?,?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"pingGuZ"],dict[@"xingMing"],dict[@"nianLing"],dict[@"lianXiDH"],dict[@"yuLaoRG"],dict[@"pingGuYY"],dict[@"saiCha"]];
}

//修改 评估基本信息
-(void)updatePingGuJBByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update PingGuJB SET pingGuZ = ? where shenFenZJ = ?",dict[@"pingGuZ"],shenFenZJ];
    [fm executeUpdate:@"update PingGuJB SET xingMing = ? where shenFenZJ = ?",dict[@"xingMing"],shenFenZJ];
    
    [fm executeUpdate:@"update PingGuJB SET nianLing = ? where shenFenZJ = ?",dict[@"nianLing"],shenFenZJ];
    [fm executeUpdate:@"update PingGuJB SET lianXiDH = ? where shenFenZJ = ?",dict[@"lianXiDH"],shenFenZJ];
    
    [fm executeUpdate:@"update PingGuJB SET yuLaoRG = ? where shenFenZJ = ?",dict[@"yuLaoRG"],shenFenZJ];
    [fm executeUpdate:@"update PingGuJB SET pingGuYY = ? where shenFenZJ = ?",dict[@"pingGuYY"],shenFenZJ];
    
    [fm executeUpdate:@"update PingGuJB SET saiCha = ? where shenFenZJ = ?",dict[@"saiCha"],shenFenZJ];
    
}

//查询 评估基本信息
-(NSArray*)selectPingGuJBByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from PingGuJB WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        PingGuJBModel * model=[[PingGuJBModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.pingGuZ=[result stringForColumn:@"pingGuZ"];
        model.xingMing=[result stringForColumn:@"xingMing"];
        
        model.nianLing=[result stringForColumn:@"nianLing"];
        model.lianXiDH=[result stringForColumn:@"lianXiDH"];
        
        model.yuLaoRG=[result stringForColumn:@"yuLaoRG"];
        model.pingGuYY=[result stringForColumn:@"pingGuYY"];
        
        model.saiCha=[result stringForColumn:@"saiCha"];
        
        
        [array addObject:model];
    }
    return array;
}

//删除 评估基本信息
-(void)deletePingGuJBByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from PingGuJB where shenFenZJ = ?", shenFenZJ];
}






//添加 日常生活能力
-(void)addRiChengSHData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into RiChengSH values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"jinShi"],dict[@"xiZao"],dict[@"xiuShi"],dict[@"chuanYi"],dict[@"daBianKZ"],dict[@"xiaoBianKZ"],dict[@"ruCe"],dict[@"chuangYiZY"],dict[@"pingDiXZ"],dict[@"shangXiaLT"],dict[@"riChangSSHDFJ"],dict[@"riChangSSHDZF"]];
}

//修改 日常生活能力
-(void)updateRiChengSHByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update RiChengSH SET jinShi = ? where shenFenZJ = ?",dict[@"jinShi"],shenFenZJ];
    [fm executeUpdate:@"update RiChengSH SET xiZao = ? where shenFenZJ = ?",dict[@"xiZao"],shenFenZJ];
    
    [fm executeUpdate:@"update RiChengSH SET xiuShi = ? where shenFenZJ = ?",dict[@"xiuShi"],shenFenZJ];
    [fm executeUpdate:@"update RiChengSH SET chuanYi = ? where shenFenZJ = ?",dict[@"chuanYi"],shenFenZJ];
    
    [fm executeUpdate:@"update RiChengSH SET daBianKZ = ? where shenFenZJ = ?",dict[@"daBianKZ"],shenFenZJ];
    [fm executeUpdate:@"update RiChengSH SET xiaoBianKZ = ? where shenFenZJ = ?",dict[@"xiaoBianKZ"],shenFenZJ];
    
    [fm executeUpdate:@"update RiChengSH SET ruCe = ? where shenFenZJ = ?",dict[@"ruCe"],shenFenZJ];
    [fm executeUpdate:@"update RiChengSH SET chuangYiZY = ? where shenFenZJ = ?",dict[@"chuangYiZY"],shenFenZJ];
    
    [fm executeUpdate:@"update RiChengSH SET pingDiXZ = ? where shenFenZJ = ?",dict[@"pingDiXZ"],shenFenZJ];
    [fm executeUpdate:@"update RiChengSH SET shangXiaLT = ? where shenFenZJ = ?",dict[@"shangXiaLT"],shenFenZJ];
    
    [fm executeUpdate:@"update RiChengSH SET riChangSSHDFJ = ? where shenFenZJ = ?",dict[@"riChangSSHDFJ"],shenFenZJ];
    [fm executeUpdate:@"update RiChengSH SET riChangSSHDZF = ? where shenFenZJ = ?",dict[@"riChangSSHDZF"],shenFenZJ];
}

//查询 日常生活能力
-(NSArray*)selectRiChengSHByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from RiChengSH WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        RiChengSHModel * model=[[RiChengSHModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.jinShi=[result stringForColumn:@"jinShi"];
        model.xiZao=[result stringForColumn:@"xiZao"];
        
        model.xiuShi=[result stringForColumn:@"xiuShi"];
        model.chuanYi=[result stringForColumn:@"chuanYi"];
        
        model.daBianKZ=[result stringForColumn:@"daBianKZ"];
        model.xiaoBianKZ=[result stringForColumn:@"xiaoBianKZ"];
        
        model.ruCe=[result stringForColumn:@"ruCe"];
        model.chuangYiZY=[result stringForColumn:@"chuangYiZY"];
        
        model.pingDiXZ=[result stringForColumn:@"pingDiXZ"];
        model.shangXiaLT=[result stringForColumn:@"shangXiaLT"];
        
        model.riChangSSHDFJ=[result stringForColumn:@"riChangSSHDFJ"];
        model.riChangSSHDZF=[result stringForColumn:@"riChangSSHDZF"];
        
        [array addObject:model];
    }
    return array;
}

//删除 日常生活能力
-(void)deleteRiChengSHByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from RiChengSH where shenFenZJ = ?", shenFenZJ];
}







//添加 精神状态
-(void)addJingShenZTData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into JingShenZT values(?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"renZhiGN"],dict[@"gongJiXW"],dict[@"yiYuZZ"],dict[@"jingShenZTFJ"],dict[@"jingShenZTZF"]];
}

//修改 精神状态
-(void)updateJingShenZTByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update JingShenZT SET renZhiGN = ? where shenFenZJ = ?",dict[@"renZhiGN"],shenFenZJ];
    [fm executeUpdate:@"update JingShenZT SET gongJiXW = ? where shenFenZJ = ?",dict[@"gongJiXW"],shenFenZJ];
    
    [fm executeUpdate:@"update JingShenZT SET yiYuZZ = ? where shenFenZJ = ?",dict[@"yiYuZZ"],shenFenZJ];
    [fm executeUpdate:@"update JingShenZT SET jingShenZTFJ = ? where shenFenZJ = ?",dict[@"jingShenZTFJ"],shenFenZJ];
    
    [fm executeUpdate:@"update JingShenZT SET jingShenZTZF = ? where shenFenZJ = ?",dict[@"jingShenZTZF"],shenFenZJ];
}

//查询 精神状态
-(NSArray*)selectJingShenZTByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from JingShenZT WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        JingShenZTModel * model=[[JingShenZTModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.renZhiGN=[result stringForColumn:@"renZhiGN"];
        model.gongJiXW=[result stringForColumn:@"gongJiXW"];
        
        model.yiYuZZ=[result stringForColumn:@"yiYuZZ"];
        model.jingShenZTFJ=[result stringForColumn:@"jingShenZTFJ"];
        
        model.jingShenZTZF=[result stringForColumn:@"jingShenZTZF"];
        
        [array addObject:model];
    }
    return array;
}

//删除 精神状态
-(void)deleteJingShenZTByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from JingShenZT where shenFenZJ = ?", shenFenZJ];
}






//添加 感知觉与沟通
-(void)addGanZhiJData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into GanZhiJ values(?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"yiShiSP"],dict[@"shiLi"],dict[@"tingLi"],dict[@"gouTongJL"],dict[@"ganZhiJYGTFJ"],dict[@"ganZhiJYGTZF"]];
}

//修改 感知觉与沟通
-(void)updateGanZhiJByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update GanZhiJ SET yiShiSP = ? where shenFenZJ = ?",dict[@"yiShiSP"],shenFenZJ];
    [fm executeUpdate:@"update GanZhiJ SET shiLi = ? where shenFenZJ = ?",dict[@"shiLi"],shenFenZJ];
    
    [fm executeUpdate:@"update GanZhiJ SET tingLi = ? where shenFenZJ = ?",dict[@"tingLi"],shenFenZJ];
    [fm executeUpdate:@"update GanZhiJ SET gouTongJL = ? where shenFenZJ = ?",dict[@"gouTongJL"],shenFenZJ];
    
    [fm executeUpdate:@"update GanZhiJ SET ganZhiJYGTFJ = ? where shenFenZJ = ?",dict[@"ganZhiJYGTFJ"],shenFenZJ];
    [fm executeUpdate:@"update GanZhiJ SET ganZhiJYGTZF = ? where shenFenZJ = ?",dict[@"ganZhiJYGTZF"],shenFenZJ];
}

//查询 感知觉与沟通
-(NSArray*)selectGanZhiJByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from GanZhiJ WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        GanZhiJModel * model=[[GanZhiJModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.yiShiSP=[result stringForColumn:@"yiShiSP"];
        model.shiLi=[result stringForColumn:@"shiLi"];
        
        model.tingLi=[result stringForColumn:@"tingLi"];
        model.gouTongJL=[result stringForColumn:@"gouTongJL"];
        
        model.ganZhiJYGTFJ=[result stringForColumn:@"ganZhiJYGTFJ"];
        model.ganZhiJYGTZF=[result stringForColumn:@"ganZhiJYGTZF"];
        
        [array addObject:model];
    }
    return array;
}

//删除 感知觉与沟通
-(void)deleteGanZhiJByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from GanZhiJ where shenFenZJ = ?", shenFenZJ];
}





//添加 社会参与
-(void)addSheHuiCYData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into SheHuiCY values(?,?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"shengHuoNL"],dict[@"gongZuoNL"],dict[@"shiJianKJ"],dict[@"renWuDX"],dict[@"sheHuiJW"],dict[@"sheHuiCYFJ"],dict[@"sheHuiCYZF"]];
}

//修改 社会参与
-(void)updateSheHuiCYByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update SheHuiCY SET shengHuoNL = ? where shenFenZJ = ?",dict[@"shengHuoNL"],shenFenZJ];
    [fm executeUpdate:@"update SheHuiCY SET gongZuoNL = ? where shenFenZJ = ?",dict[@"gongZuoNL"],shenFenZJ];
    
    [fm executeUpdate:@"update SheHuiCY SET shiJianKJ = ? where shenFenZJ = ?",dict[@"shiJianKJ"],shenFenZJ];
    [fm executeUpdate:@"update SheHuiCY SET renWuDX = ? where shenFenZJ = ?",dict[@"renWuDX"],shenFenZJ];
    
    [fm executeUpdate:@"update SheHuiCY SET sheHuiJW = ? where shenFenZJ = ?",dict[@"sheHuiJW"],shenFenZJ];
    [fm executeUpdate:@"update SheHuiCY SET sheHuiCYFJ = ? where shenFenZJ = ?",dict[@"sheHuiCYFJ"],shenFenZJ];
    
    [fm executeUpdate:@"update SheHuiCY SET sheHuiCYZF = ? where shenFenZJ = ?",dict[@"sheHuiCYZF"],shenFenZJ];
}

//查询 社会参与
-(NSArray*)selectSheHuiCYByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from SheHuiCY WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        SheHuiCYModel * model=[[SheHuiCYModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.shengHuoNL=[result stringForColumn:@"shengHuoNL"];
        model.gongZuoNL=[result stringForColumn:@"gongZuoNL"];
        
        model.shiJianKJ=[result stringForColumn:@"shiJianKJ"];
        model.renWuDX=[result stringForColumn:@"renWuDX"];
        
        model.sheHuiJW=[result stringForColumn:@"sheHuiJW"];
        model.sheHuiCYFJ=[result stringForColumn:@"sheHuiCYFJ"];
        
        model.sheHuiCYZF=[result stringForColumn:@"sheHuiCYZF"];
        
        [array addObject:model];
    }
    return array;
}

//删除 社会参与
-(void)deleteSheHuiCYByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from SheHuiCY where shenFenZJ = ?", shenFenZJ];
}





//添加 补充评估信息
-(void)addBuChongPGData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into BuChongPG values(?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"laoNianCZ"],dict[@"jingShenJB"],dict[@"dieDao"],dict[@"yeShi"],dict[@"zouShi"],dict[@"ziSha"]];
}

//修改 补充评估信息
-(void)updateBuChongPGByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update BuChongPG SET laoNianCZ = ? where shenFenZJ = ?",dict[@"laoNianCZ"],shenFenZJ];
    [fm executeUpdate:@"update BuChongPG SET jingShenJB = ? where shenFenZJ = ?",dict[@"jingShenJB"],shenFenZJ];
    
    [fm executeUpdate:@"update BuChongPG SET dieDao = ? where shenFenZJ = ?",dict[@"dieDao"],shenFenZJ];
    [fm executeUpdate:@"update BuChongPG SET yeShi = ? where shenFenZJ = ?",dict[@"yeShi"],shenFenZJ];
    
    [fm executeUpdate:@"update BuChongPG SET zouShi = ? where shenFenZJ = ?",dict[@"zouShi"],shenFenZJ];
    [fm executeUpdate:@"update BuChongPG SET ziSha = ? where shenFenZJ = ?",dict[@"ziSha"],shenFenZJ];
}

//查询 补充评估信息
-(NSArray*)selectBuChongPGByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from BuChongPG WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        BuChongPGModel * model=[[BuChongPGModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.laoNianCZ=[result stringForColumn:@"laoNianCZ"];
        model.jingShenJB=[result stringForColumn:@"jingShenJB"];
        
        model.dieDao=[result stringForColumn:@"dieDao"];
        model.yeShi=[result stringForColumn:@"yeShi"];
        
        model.zouShi=[result stringForColumn:@"zouShi"];
        model.ziSha=[result stringForColumn:@"ziSha"];
        
        [array addObject:model];
    }
    return array;
}

//删除 补充评估信息
-(void)deleteBuChongPGByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from BuChongPG where shenFenZJ = ?", shenFenZJ];
}






//添加 能力评估结论
-(void)addNengLiPGData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into NengLiPG values(?,?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"riChangSH"],dict[@"jingShenZT"],dict[@"ganZhiJY"],dict[@"sheHuiCY"],dict[@"nengLiDJ"],dict[@"dengJiBG"],dict[@"nengLiZZ"]];
}

//修改 能力评估结论
-(void)updateNengLiPGByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update NengLiPG SET riChangSH = ? where shenFenZJ = ?",dict[@"riChangSH"],shenFenZJ];
    [fm executeUpdate:@"update NengLiPG SET jingShenZT = ? where shenFenZJ = ?",dict[@"jingShenZT"],shenFenZJ];
    
    [fm executeUpdate:@"update NengLiPG SET ganZhiJY = ? where shenFenZJ = ?",dict[@"ganZhiJY"],shenFenZJ];
    [fm executeUpdate:@"update NengLiPG SET sheHuiCY = ? where shenFenZJ = ?",dict[@"sheHuiCY"],shenFenZJ];
    
    [fm executeUpdate:@"update NengLiPG SET nengLiDJ = ? where shenFenZJ = ?",dict[@"nengLiDJ"],shenFenZJ];
    [fm executeUpdate:@"update NengLiPG SET dengJiBG = ? where shenFenZJ = ?",dict[@"dengJiBG"],shenFenZJ];
    
    [fm executeUpdate:@"update NengLiPG SET nengLiZZ = ? where shenFenZJ = ?",dict[@"nengLiZZ"],shenFenZJ];
}

//查询 能力评估结论
-(NSArray*)selectNengLiPGByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from NengLiPG WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        NengLiPGModel * model=[[NengLiPGModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.riChangSSHDFJ=[result stringForColumn:@"riChangSH"];
        model.jingShenZTFJ=[result stringForColumn:@"jingShenZT"];
        
        model.ganZhiJYGTFJ=[result stringForColumn:@"ganZhiJY"];
        model.sheHuiCYFJ=[result stringForColumn:@"sheHuiCY"];
        
        model.nengLiDJ=[result stringForColumn:@"nengLiDJ"];
        model.dengJiBG=[result stringForColumn:@"dengJiBG"];
        model.nengLiZZ=[result stringForColumn:@"nengLiZZ"];
        
        [array addObject:model];
    }
    return array;
}

//删除 能力评估结论
-(void)deleteNengLiPGByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from NengLiPG where shenFenZJ = ?", shenFenZJ];
}






//添加 评估补充说明
-(void)addPingGuBCData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into PingGuBC values(?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"pingGuBC"]];
}

//修改 评估补充说明
-(void)updatePingGuBCByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update PingGuBC SET pingGuBC = ? where shenFenZJ = ?",dict[@"pingGuBC"],shenFenZJ];

}

//查询 评估补充说明
-(NSArray*)selectPingGuBCByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from PingGuBC WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        PingGuBCModel * model=[[PingGuBCModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];

        model.pingGuBC=[result stringForColumn:@"pingGuBC"];
        
        [array addObject:model];
    }
    return array;
}

//删除 评估补充说明
-(void)deletePingGuBCByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from PingGuBC where shenFenZJ = ?", shenFenZJ];
}







//添加 营养膳食
-(void)addYingYangSSData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into YingYangSS values(?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"need"],dict[@"yingYangSS"],dict[@"sanShiZB"],dict[@"songCan"],dict[@"jinShiFW"]];
}

//修改 营养膳食
-(void)updateYingYangSSByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update YingYangSS SET need = ? where shenFenZJ = ?",dict[@"need"],shenFenZJ];
    
    [fm executeUpdate:@"update YingYangSS SET yingYangSS = ? where shenFenZJ = ?",dict[@"yingYangSS"],shenFenZJ];
    [fm executeUpdate:@"update YingYangSS SET sanShiZB = ? where shenFenZJ = ?",dict[@"sanShiZB"],shenFenZJ];
    
    [fm executeUpdate:@"update YingYangSS SET songCan = ? where shenFenZJ = ?",dict[@"songCan"],shenFenZJ];
    [fm executeUpdate:@"update YingYangSS SET jinShiFW = ? where shenFenZJ = ?",dict[@"jinShiFW"],shenFenZJ];
    
}

//查询 营养膳食
-(NSArray*)selectYingYangSSByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from YingYangSS WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        YingYangSSModel * model=[[YingYangSSModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.need=[result stringForColumn:@"need"];
        
        model.yingYangSS=[result stringForColumn:@"yingYangSS"];
        model.sanShiZB=[result stringForColumn:@"sanShiZB"];
        
        model.songCan=[result stringForColumn:@"songCan"];
        model.jinShiFW=[result stringForColumn:@"jinShiFW"];
        
        [array addObject:model];
    }
    return array;
}

//删除 营养膳食
-(void)deleteYingYangSSByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from YingYangSS where shenFenZJ = ?", shenFenZJ];
}






//添加 医疗卫生
-(void)addYiLiaoWSData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into YiLiaoWS values(?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"need"],dict[@"shengLiZB"],dict[@"dingQiJX"],dict[@"dingQiJC"],dict[@"kangFuDL"],dict[@"dingQiPT"]];
}

//修改 医疗卫生
-(void)updateYiLiaoWSByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update YiLiaoWS SET need = ? where shenFenZJ = ?",dict[@"need"],shenFenZJ];
    
    [fm executeUpdate:@"update YiLiaoWS SET shengLiZB = ? where shenFenZJ = ?",dict[@"shengLiZB"],shenFenZJ];
    [fm executeUpdate:@"update YiLiaoWS SET dingQiJX = ? where shenFenZJ = ?",dict[@"dingQiJX"],shenFenZJ];
    
    [fm executeUpdate:@"update YiLiaoWS SET dingQiJC = ? where shenFenZJ = ?",dict[@"dingQiJC"],shenFenZJ];
    [fm executeUpdate:@"update YiLiaoWS SET kangFuDL = ? where shenFenZJ = ?",dict[@"kangFuDL"],shenFenZJ];
    
    [fm executeUpdate:@"update YiLiaoWS SET dingQiPT = ? where shenFenZJ = ?",dict[@"dingQiPT"],shenFenZJ];
    
}

//查询 医疗卫生
-(NSArray*)selectYiLiaoWSByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from YiLiaoWS WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        YiLiaoWSModel * model=[[YiLiaoWSModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.need=[result stringForColumn:@"need"];
        
        model.shengLiZB=[result stringForColumn:@"shengLiZB"];
        model.dingQiJX=[result stringForColumn:@"dingQiJX"];
        
        model.dingQiJC=[result stringForColumn:@"dingQiJC"];
        model.kangFuDL=[result stringForColumn:@"kangFuDL"];
        
        model.dingQiPT=[result stringForColumn:@"dingQiPT"];
        
        [array addObject:model];
    }
    return array;
}

//删除 医疗卫生
-(void)deleteYiLiaoWSByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from YiLiaoWS where shenFenZJ = ?", shenFenZJ];
}






//添加 家庭护理
-(void)addJiaTingHLData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into JiaTingHL values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"need"],dict[@"qiChuangJQ"],dict[@"zhuYu"],dict[@"geRenXS"],dict[@"ruCeTX"],dict[@"dingQiGH"],dict[@"daXiaoPB"],dict[@"fuYaoJC"],dict[@"yaChuangHL"],dict[@"jiaTingZHZJ"],dict[@"jiaTingZHZT"],dict[@"jiaTingZHFW"]];
}

//修改 家庭护理
-(void)updateJiaTingHLByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update JiaTingHL SET need = ? where shenFenZJ = ?",dict[@"need"],shenFenZJ];
    
    [fm executeUpdate:@"update JiaTingHL SET qiChuangJQ = ? where shenFenZJ = ?",dict[@"qiChuangJQ"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingHL SET zhuYu = ? where shenFenZJ = ?",dict[@"zhuYu"],shenFenZJ];
    
    [fm executeUpdate:@"update JiaTingHL SET geRenXS = ? where shenFenZJ = ?",dict[@"geRenXS"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingHL SET ruCeTX = ? where shenFenZJ = ?",dict[@"ruCeTX"],shenFenZJ];
    
    [fm executeUpdate:@"update JiaTingHL SET dingQiGH = ? where shenFenZJ = ?",dict[@"dingQiGH"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingHL SET daXiaoPB = ? where shenFenZJ = ?",dict[@"daXiaoPB"],shenFenZJ];
    
    [fm executeUpdate:@"update JiaTingHL SET fuYaoJC = ? where shenFenZJ = ?",dict[@"fuYaoJC"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingHL SET yaChuangHL = ? where shenFenZJ = ?",dict[@"yaChuangHL"],shenFenZJ];
    
    [fm executeUpdate:@"update JiaTingHL SET jiaTingZHZJ = ? where shenFenZJ = ?",dict[@"jiaTingZHZJ"],shenFenZJ];
    [fm executeUpdate:@"update JiaTingHL SET jiaTingZHZT = ? where shenFenZJ = ?",dict[@"jiaTingZHZT"],shenFenZJ];
    
    [fm executeUpdate:@"update JiaTingHL SET jiaTingZHFW = ? where shenFenZJ = ?",dict[@"jiaTingZHFW"],shenFenZJ];
    
}

//查询 家庭护理
-(NSArray*)selectJiaTingHLByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from JiaTingHL WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        JiaTingHLModel * model=[[JiaTingHLModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.need=[result stringForColumn:@"need"];
        
        model.qiChuangJQ=[result stringForColumn:@"qiChuangJQ"];
        model.zhuYu=[result stringForColumn:@"zhuYu"];
        
        model.geRenXS=[result stringForColumn:@"geRenXS"];
        model.ruCeTX=[result stringForColumn:@"ruCeTX"];
        
        model.dingQiGH=[result stringForColumn:@"dingQiGH"];
        model.daXiaoPB=[result stringForColumn:@"daXiaoPB"];
        
        model.fuYaoJC=[result stringForColumn:@"fuYaoJC"];
        model.yaChuangHL=[result stringForColumn:@"yaChuangHL"];
        
        model.jiaTingZHZJ=[result stringForColumn:@"jiaTingZHZJ"];
        model.jiaTingZHZT=[result stringForColumn:@"jiaTingZHZT"];
        
        model.jiaTingZHFW=[result stringForColumn:@"jiaTingZHFW"];
        
        [array addObject:model];
    }
    return array;
}

//删除 家庭护理
-(void)deleteJiaTingHLByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from JiaTingHL where shenFenZJ = ?", shenFenZJ];
}






//添加 紧急救援
-(void)addJinJiJYData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into JinJiJY values(?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"need"],dict[@"anZhuangAQ"],dict[@"dingQiJT"],dict[@"jiaTingKJ"],dict[@"yuanChengAQ"],dict[@"yingJiJY"]];
}

//修改 紧急救援
-(void)updateJinJiJYByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update JinJiJY SET need = ? where shenFenZJ = ?",dict[@"need"],shenFenZJ];
    
    [fm executeUpdate:@"update JinJiJY SET anZhuangAQ = ? where shenFenZJ = ?",dict[@"anZhuangAQ"],shenFenZJ];
    [fm executeUpdate:@"update JinJiJY SET dingQiJT = ? where shenFenZJ = ?",dict[@"dingQiJT"],shenFenZJ];
    
    [fm executeUpdate:@"update JinJiJY SET jiaTingKJ = ? where shenFenZJ = ?",dict[@"jiaTingKJ"],shenFenZJ];
    [fm executeUpdate:@"update JinJiJY SET yuanChengAQ = ? where shenFenZJ = ?",dict[@"yuanChengAQ"],shenFenZJ];
    
    [fm executeUpdate:@"update JinJiJY SET yingJiJY = ? where shenFenZJ = ?",dict[@"yingJiJY"],shenFenZJ];
    
}

//查询 紧急救援
-(NSArray*)selectJinJiJYByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from JinJiJY WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        JinJiJYModel * model=[[JinJiJYModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.need=[result stringForColumn:@"need"];
        
        model.anZhuangAQ=[result stringForColumn:@"anZhuangAQ"];
        model.dingQiJT=[result stringForColumn:@"dingQiJT"];
        
        model.jiaTingKJ=[result stringForColumn:@"jiaTingKJ"];
        model.yuanChengAQ=[result stringForColumn:@"yuanChengAQ"];
        
        model.yingJiJY=[result stringForColumn:@"yingJiJY"];
        
        [array addObject:model];
    }
    return array;
}

//删除 紧急救援
-(void)deleteJinJiJYByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from JinJiJY where shenFenZJ = ?", shenFenZJ];
}







//添加 社区日间照料
-(void)addSheQuRJData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into SheQuRJ values(?,?,?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"need"],dict[@"yingYangSS"],dict[@"geRenSS"],dict[@"fuYaoGL"],dict[@"kangFuXL"],dict[@"yiWuXD"],dict[@"xinLiSD"],dict[@"sheJiaoYL"]];
}

//修改 社区日间照料
-(void)updateSheQuRJByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update SheQuRJ SET need = ? where shenFenZJ = ?",dict[@"need"],shenFenZJ];
    
    [fm executeUpdate:@"update SheQuRJ SET yingYangSS = ? where shenFenZJ = ?",dict[@"yingYangSS"],shenFenZJ];
    [fm executeUpdate:@"update SheQuRJ SET geRenSS = ? where shenFenZJ = ?",dict[@"geRenSS"],shenFenZJ];
    
    [fm executeUpdate:@"update SheQuRJ SET fuYaoGL = ? where shenFenZJ = ?",dict[@"fuYaoGL"],shenFenZJ];
    [fm executeUpdate:@"update SheQuRJ SET kangFuXL = ? where shenFenZJ = ?",dict[@"kangFuXL"],shenFenZJ];
    
    [fm executeUpdate:@"update SheQuRJ SET yiWuXD = ? where shenFenZJ = ?",dict[@"yiWuXD"],shenFenZJ];
    [fm executeUpdate:@"update SheQuRJ SET xinLiSD = ? where shenFenZJ = ?",dict[@"xinLiSD"],shenFenZJ];
    
    [fm executeUpdate:@"update SheQuRJ SET sheJiaoYL = ? where shenFenZJ = ?",dict[@"sheJiaoYL"],shenFenZJ];
    
}

//查询 社区日间照料
-(NSArray*)selectSheQuRJByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from SheQuRJ WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        SheQuRJModel * model=[[SheQuRJModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.need=[result stringForColumn:@"need"];
        
        model.yingYangSS=[result stringForColumn:@"yingYangSS"];
        model.geRenSS=[result stringForColumn:@"geRenSS"];
        
        model.fuYaoGL=[result stringForColumn:@"fuYaoGL"];
        model.kangFuXL=[result stringForColumn:@"kangFuXL"];
        
        model.yiWuXD=[result stringForColumn:@"yiWuXD"];
        model.xinLiSD=[result stringForColumn:@"xinLiSD"];
        
        model.sheJiaoYL=[result stringForColumn:@"sheJiaoYL"];
        
        [array addObject:model];
    }
    return array;
}

//删除 社区日间照料
-(void)deleteSheQuRJByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from SheQuRJ where shenFenZJ = ?", shenFenZJ];
}







//添加 家政服务
-(void)addJiaZhengFWData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into JiaZhengFW values(?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"need"],dict[@"caiGouRC"],dict[@"jiaTingQJ"],dict[@"chuangShangYP"],dict[@"xiDiZL"],dict[@"duLiSS"]];
}

//修改 家政服务
-(void)updateJiaZhengFWByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update JiaZhengFW SET need = ? where shenFenZJ = ?",dict[@"need"],shenFenZJ];
    
    [fm executeUpdate:@"update JiaZhengFW SET caiGouRC = ? where shenFenZJ = ?",dict[@"caiGouRC"],shenFenZJ];
    [fm executeUpdate:@"update JiaZhengFW SET jiaTingQJ = ? where shenFenZJ = ?",dict[@"jiaTingQJ"],shenFenZJ];
    
    [fm executeUpdate:@"update JiaZhengFW SET chuangShangYP = ? where shenFenZJ = ?",dict[@"chuangShangYP"],shenFenZJ];
    [fm executeUpdate:@"update JiaZhengFW SET xiDiZL = ? where shenFenZJ = ?",dict[@"xiDiZL"],shenFenZJ];
    
    [fm executeUpdate:@"update JiaZhengFW SET duLiSS = ? where shenFenZJ = ?",dict[@"duLiSS"],shenFenZJ];
    
}

//查询 家政服务
-(NSArray*)selectJiaZhengFWByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from JiaZhengFW WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        JiaZhengFWModel * model=[[JiaZhengFWModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.need=[result stringForColumn:@"need"];
        
        model.caiGouRC=[result stringForColumn:@"caiGouRC"];
        model.jiaTingQJ=[result stringForColumn:@"jiaTingQJ"];
        
        model.chuangShangYP=[result stringForColumn:@"chuangShangYP"];
        model.xiDiZL=[result stringForColumn:@"xiDiZL"];
        
        model.duLiSS=[result stringForColumn:@"duLiSS"];
        
        [array addObject:model];
    }
    return array;
}

//删除 家政服务
-(void)deleteJiaZhengFWByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from JiaZhengFW where shenFenZJ = ?", shenFenZJ];
}







//添加 心理及文娱活动
-(void)addXinLiWYData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into XinLiWY values(?,?,?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"need"],dict[@"shengHuoJN"],dict[@"guanHuanFS"],dict[@"sheJiaoSS"],dict[@"jiaTingWH"],dict[@"xinLiZX"],dict[@"buLiangQX"],dict[@"chuXingJH"]];
}

//修改 心理及文娱活动
-(void)updateXinLiWYByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update XinLiWY SET need = ? where shenFenZJ = ?",dict[@"need"],shenFenZJ];
    
    [fm executeUpdate:@"update XinLiWY SET shengHuoJN = ? where shenFenZJ = ?",dict[@"shengHuoJN"],shenFenZJ];
    [fm executeUpdate:@"update XinLiWY SET guanHuanFS = ? where shenFenZJ = ?",dict[@"guanHuanFS"],shenFenZJ];
    
    [fm executeUpdate:@"update XinLiWY SET sheJiaoSS = ? where shenFenZJ = ?",dict[@"sheJiaoSS"],shenFenZJ];
    [fm executeUpdate:@"update XinLiWY SET jiaTingWH = ? where shenFenZJ = ?",dict[@"jiaTingWH"],shenFenZJ];
    
    [fm executeUpdate:@"update XinLiWY SET xinLiZX = ? where shenFenZJ = ?",dict[@"xinLiZX"],shenFenZJ];
    [fm executeUpdate:@"update XinLiWY SET buLiangQX = ? where shenFenZJ = ?",dict[@"buLiangQX"],shenFenZJ];
    
    [fm executeUpdate:@"update XinLiWY SET chuXingJH = ? where shenFenZJ = ?",dict[@"chuXingJH"],shenFenZJ];
    
}

//查询 心理及文娱活动
-(NSArray*)selectXinLiWYByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from XinLiWY WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        XinLiWYModel * model=[[XinLiWYModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.need=[result stringForColumn:@"need"];
        
        model.shengHuoJN=[result stringForColumn:@"shengHuoJN"];
        model.guanHuanFS=[result stringForColumn:@"guanHuanFS"];
        
        model.sheJiaoSS=[result stringForColumn:@"sheJiaoSS"];
        model.jiaTingWH=[result stringForColumn:@"jiaTingWH"];
        
        model.xinLiZX=[result stringForColumn:@"xinLiZX"];
        model.buLiangQX=[result stringForColumn:@"buLiangQX"];
        
        model.chuXingJH=[result stringForColumn:@"chuXingJH"];
        
        [array addObject:model];
    }
    return array;
}

//删除 心理及文娱活动
-(void)deleteXinLiWYByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from XinLiWY where shenFenZJ = ?", shenFenZJ];
}







//添加 其他
-(void)addQiTaData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into QiTa values(?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"need"],dict[@"ruZhuYL"],dict[@"duanQiSQ"],dict[@"fuJuPZ"],dict[@"gouMaiCQ"],dict[@"gouMaiYW"]];
}

//修改 其他
-(void)updateQiTaByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update QiTa SET need = ? where shenFenZJ = ?",dict[@"need"],shenFenZJ];
    
    [fm executeUpdate:@"update QiTa SET ruZhuYL = ? where shenFenZJ = ?",dict[@"ruZhuYL"],shenFenZJ];
    [fm executeUpdate:@"update QiTa SET duanQiSQ = ? where shenFenZJ = ?",dict[@"duanQiSQ"],shenFenZJ];
    
    [fm executeUpdate:@"update QiTa SET fuJuPZ = ? where shenFenZJ = ?",dict[@"fuJuPZ"],shenFenZJ];
    [fm executeUpdate:@"update QiTa SET gouMaiCQ = ? where shenFenZJ = ?",dict[@"gouMaiCQ"],shenFenZJ];
    
    [fm executeUpdate:@"update QiTa SET gouMaiYW = ? where shenFenZJ = ?",dict[@"gouMaiYW"],shenFenZJ];
    
}

//查询 其他
-(NSArray*)selectQiTaByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from QiTa WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        QiTaModel * model=[[QiTaModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.need=[result stringForColumn:@"need"];
        
        model.ruZhuYL=[result stringForColumn:@"ruZhuYL"];
        model.duanQiSQ=[result stringForColumn:@"duanQiSQ"];
        
        model.fuJuPZ=[result stringForColumn:@"fuJuPZ"];
        model.gouMaiCQ=[result stringForColumn:@"gouMaiCQ"];
        
        model.gouMaiYW=[result stringForColumn:@"gouMaiYW"];
        
        [array addObject:model];
    }
    return array;
}

//删除 其他
-(void)deleteQiTaByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from QiTa where shenFenZJ = ?", shenFenZJ];
}






//添加 特殊服务需求
-(void)addTeShuFWData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into TeShuFW values(?,?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"need"],dict[@"teShuFW1"],dict[@"teShuFW2"],dict[@"teShuFW3"],dict[@"teShuFW4"],dict[@"teShuFW5"],dict[@"teShuFW6"]];
}

//修改 特殊服务需求
-(void)updateTeShuFWByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update TeShuFW SET need = ? where shenFenZJ = ?",dict[@"need"],shenFenZJ];
    
    [fm executeUpdate:@"update TeShuFW SET teShuFW1 = ? where shenFenZJ = ?",dict[@"teShuFW1"],shenFenZJ];
    [fm executeUpdate:@"update TeShuFW SET teShuFW2 = ? where shenFenZJ = ?",dict[@"teShuFW2"],shenFenZJ];
    
    [fm executeUpdate:@"update TeShuFW SET teShuFW3 = ? where shenFenZJ = ?",dict[@"teShuFW3"],shenFenZJ];
    [fm executeUpdate:@"update TeShuFW SET teShuFW4 = ? where shenFenZJ = ?",dict[@"teShuFW4"],shenFenZJ];
    
    [fm executeUpdate:@"update TeShuFW SET teShuFW5 = ? where shenFenZJ = ?",dict[@"teShuFW5"],shenFenZJ];
    [fm executeUpdate:@"update TeShuFW SET teShuFW6 = ? where shenFenZJ = ?",dict[@"teShuFW6"],shenFenZJ];
}

//查询 特殊服务需求
-(NSArray*)selectTeShuFWByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from TeShuFW WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        TeShuFWModel * model=[[TeShuFWModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.need=[result stringForColumn:@"need"];
        
        model.teShuFW1=[result stringForColumn:@"teShuFW1"];
        model.teShuFW2=[result stringForColumn:@"teShuFW2"];
        
        model.teShuFW3=[result stringForColumn:@"teShuFW3"];
        model.teShuFW4=[result stringForColumn:@"teShuFW4"];
        
        model.teShuFW5=[result stringForColumn:@"teShuFW5"];
        model.teShuFW6=[result stringForColumn:@"teShuFW6"];
        
        [array addObject:model];
    }
    return array;
}

//删除 特殊服务需求
-(void)deleteTeShuFWByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from TeShuFW where shenFenZJ = ?", shenFenZJ];
}






//添加 养老助餐调研
-(void)addYangLaoZCData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into YangLaoZC values(?,?,?,?,?,?,?,?,?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"juZhuQK"],dict[@"yueShouRQ"],dict[@"ninShiFS"],dict[@"shiFouXY"],dict[@"ninXuYP"],dict[@"ninSongCL"],dict[@"ninRenWP"],dict[@"ninDuiYS"],dict[@"ninDuiYL"]];
}

//修改 养老助餐调研
-(void)updateYangLaoZCByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    
    [fm executeUpdate:@"update YangLaoZC SET juZhuQK = ? where shenFenZJ = ?",dict[@"juZhuQK"],shenFenZJ];
    [fm executeUpdate:@"update YangLaoZC SET yueShouRQ = ? where shenFenZJ = ?",dict[@"yueShouRQ"],shenFenZJ];
    
    [fm executeUpdate:@"update YangLaoZC SET ninShiFS = ? where shenFenZJ = ?",dict[@"ninShiFS"],shenFenZJ];
    [fm executeUpdate:@"update YangLaoZC SET shiFouXY = ? where shenFenZJ = ?",dict[@"shiFouXY"],shenFenZJ];
    
    [fm executeUpdate:@"update YangLaoZC SET ninXuYP = ? where shenFenZJ = ?",dict[@"ninXuYP"],shenFenZJ];
    [fm executeUpdate:@"update YangLaoZC SET ninSongCL = ? where shenFenZJ = ?",dict[@"ninSongCL"],shenFenZJ];
    
    [fm executeUpdate:@"update YangLaoZC SET ninRenWP = ? where shenFenZJ = ?",dict[@"ninRenWP"],shenFenZJ];
    [fm executeUpdate:@"update YangLaoZC SET ninDuiYS = ? where shenFenZJ = ?",dict[@"ninDuiYS"],shenFenZJ];
    
    [fm executeUpdate:@"update YangLaoZC SET ninDuiYL = ? where shenFenZJ = ?",dict[@"ninDuiYL"],shenFenZJ];
}

//查询 养老助餐调研
-(NSArray*)selectYangLaoZCByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from YangLaoZC WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        YangLaoZCModel * model=[[YangLaoZCModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.juZhuQK=[result stringForColumn:@"juZhuQK"];
        model.yueShouRQ=[result stringForColumn:@"yueShouRQ"];
        
        model.ninShiFS=[result stringForColumn:@"ninShiFS"];
        model.shiFouXY=[result stringForColumn:@"shiFouXY"];
        
        model.ninXuYP=[result stringForColumn:@"ninXuYP"];
        model.ninSongCL=[result stringForColumn:@"ninSongCL"];
        
        model.ninRenWP=[result stringForColumn:@"ninRenWP"];
        model.ninDuiYS=[result stringForColumn:@"ninDuiYS"];
        
        model.ninDuiYL=[result stringForColumn:@"ninDuiYL"];
        
        [array addObject:model];
    }
    return array;
}

//删除 养老助餐调研
-(void)deleteYangLaoZCByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from YangLaoZC where shenFenZJ = ?", shenFenZJ];
}





//添加 补充信息
-(void)addBuChongXXData:(NSDictionary*)dict
{
    [fm executeUpdate:@"insert into BuChongXX values(?,?,?,?)",dict[@"doc_id"],dict[@"shenFenZJ"],dict[@"tableFlag"],dict[@"buChongXX"]];
}

//修改 补充信息
-(void)updateBuChongXXByShenFenZJ:(NSString*)shenFenZJ dict:(NSDictionary*)dict
{
    [fm executeUpdate:@"update BuChongXX SET buChongXX = ? where shenFenZJ = ?",dict[@"buChongXX"],shenFenZJ];

}

//查询 补充信息
-(NSArray*)selectBuChongXXByShenFenZJ:(NSString*)shenFenZJ
{
    FMResultSet * result=[fm executeQuery:@"select * from BuChongXX WHERE shenFenZJ = ?",shenFenZJ];
    NSMutableArray * array=[[NSMutableArray alloc]init];
    while ([result next]) {
        BuChongXXModel * model=[[BuChongXXModel alloc]init];
        
        model.DOC_ID=[result stringForColumn:@"doc_id"];
        model.shenFenZJ=[result stringForColumn:@"chuanRanJB"];
        model.tableFlag=[result stringForColumn:@"tableFlag"];
        
        model.buChongXX=[result stringForColumn:@"buChongXX"];
        
        [array addObject:model];
    }
    return array;
}

//删除 补充信息
-(void)deleteBuChongXXByShenFenZJ:(NSString*)shenFenZJ
{
    [fm executeUpdate:@"delete from BuChongXX where shenFenZJ = ?", shenFenZJ];
}
 */


@end
