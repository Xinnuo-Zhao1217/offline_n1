--- ods
-- 运单表
drop table ods_order_info;
CREATE TABLE `ods_order_info` (
                                  `id` int COMMENT 'id',
                                  `order_no` string COMMENT '订单号',
                                  `status` string COMMENT '订单状态',
                                  `collect_type` string COMMENT '取件类型，1为网点自寄，2为上门取件',
                                  `user_id` int COMMENT '客户id',
                                  `receiver_complex_id` int COMMENT '收件人小区id',
                                  `receiver_province_id` string COMMENT '收件人省份id',
                                  `receiver_city_id` string COMMENT '收件人城市id',
                                  `receiver_district_id` string COMMENT '收件人区县id',
                                  `receiver_address` string COMMENT '收件人详细地址',
                                  `receiver_name` string COMMENT '收件人姓名',
                                  `receiver_phone` string COMMENT '收件人电话',
                                  `receive_location` string COMMENT '起始点经纬度',
                                  `sender_complex_id` int COMMENT '发件人小区id',
                                  `sender_province_id` string COMMENT '发件人省份id',
                                  `sender_city_id` string COMMENT '发件人城市id',
                                  `sender_district_id` string COMMENT '发件人区县id',
                                  `sender_address` string COMMENT '发件人详细地址',
                                  `sender_name` string COMMENT '发件人姓名',
                                  `sender_phone` string COMMENT '发件人电话',
                                  `send_location` string COMMENT '发件人坐标',
                                  `payment_type` string COMMENT '支付方式',
                                  `cargo_num` int COMMENT '货物个数',
                                  `amount` decimal(32,2) COMMENT '金额',
                                  `estimate_arrive_time` date COMMENT '预计到达时间',
                                  `distance` decimal(10,2) COMMENT '距离，单位：公里',
                                  `create_time` timestamp COMMENT '创建时间',
                                  `update_time` timestamp COMMENT '更新时间',
                                  `is_deleted` string COMMENT '删除标记（0:不可用 1:可用）'
) partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/user/hive/warehouse/dev_realtime_tms01_xinnuo_zhao.db/hivetablename/ods/ods_order_info'
tblproperties ("parquet.compression"="gzip");
load data inpath "/2207A/zhaoxinnuo/tms/order_info/2025-03-24/"
into table ods_order_info partition (dt='2025-03-24');
select * from ods_order_info;

-- 运单明细表
drop table ods_order_cargo;
CREATE TABLE `ods_order_cargo` (
                                   id            bigint ,
                                   order_id      string         comment '订单id',
                                   cargo_type    string comment '货物类型id',
                                   volume_length int                     comment '长cm',
                                   volume_width  int                     comment '宽cm',
                                   volume_height int                      comment '高cm',
                                   weight        decimal(16, 2)          comment '重量 kg',
                                   remark        string                 comment '备注',
                                   create_time   string             comment '创建时间',
                                   update_time   string            comment '更新时间',
                                   is_deleted    string comment '删除标记（0:不可用 1:可用）'
)partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/user/hive/warehouse/dev_realtime_tms01_xinnuo_zhao.db/hivetablename/ods/ods_order_cargo'
tblproperties ("parquet.compression"="snappy");
load data inpath "/2207A/zhaoxinnuo/tms/order_cargo/2025-03-24/"
into table ods_order_cargo partition (dt='2025-03-24');
select * from ods_order_cargo;

-- 字典表
drop table ods_base_dic;
CREATE TABLE `ods_base_dic` (
                                `id` int COMMENT 'id',
                                `parent_id` string COMMENT '上级id',
                                `name` string COMMENT '名称',
                                `dict_code` string COMMENT '编码',
                                `create_time` timestamp COMMENT '创建时间',
                                `update_time` timestamp COMMENT '更新时间',
                                `is_deleted` string COMMENT '删除标记（0:不可用 1:可用）'
)partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/user/hive/warehouse/dev_realtime_tms01_xinnuo_zhao.db/hivetablename/ods/ods_base_dic'
tblproperties ("parquet.compression"="gzip");
load data inpath '/2207A/zhaoxinnuo/tms/base_dic/2025-03-24/'
into table ods_base_dic partition (dt='2025-03-24');
select * from ods_base_dic;

-- 小区表
drop table ods_base_complex;
CREATE TABLE `ods_base_complex` (
                                    `id` int,
                                    `complex_name` string,
                                    `province_id` string,
                                    `city_id` string,
                                    `district_id` string,
                                    `district_name` string,
                                    `create_time` string ,
                                    `update_time` string,
                                    `is_deleted` string
)partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/user/hive/warehouse/dev_realtime_tms01_xinnuo_zhao.db/hivetablename/ods/ods_base_complex'
tblproperties ("parquet.compression"="gzip");
load data inpath '/2207A/zhaoxinnuo/tms/base_complex/2025-03-24/'
into table ods_base_complex partition (dt='2025-03-24');
select * from ods_base_complex;

-- 地区表
drop table ods_base_region_info;
CREATE TABLE `ods_base_region_info` (
                                        id          bigint               comment 'id',
                                        parent_id   string               comment '上级id',
                                        name        string               comment '名称',
                                        dict_code   string               comment '编码',
                                        short_name  string               comment '简称',
                                        create_time string               comment '创建时间',
                                        update_time string               comment '更新时间',
                                        is_deleted  string               comment '删除标记（0:不可用 1:可用）'
) partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/user/hive/warehouse/dev_realtime_tms01_xinnuo_zhao.db/hivetablename/ods/ods_base_region_info'
tblproperties ("parquet.compression"="gzip");
load data inpath "/2207A/zhaoxinnuo/tms/base_region_info/2025-03-24/"
overwrite into table ods_base_region_info partition (dt='2025-03-24');
select * from ods_base_region_info;

-- 机构表
CREATE TABLE `ods_base_organ` (
                                  `id` int,
                                  `org_name` string COMMENT '机构名称',
                                  `org_level` string COMMENT '行政级别',
                                  `region_id` string COMMENT '区域id，1级机构为city ,2级机构为district',
                                  `org_parent_id` string COMMENT '上级机构id',
                                  `points` string COMMENT '多边形经纬度坐标集合',
                                  `create_time` string COMMENT '创建时间',
                                  `update_time` string COMMENT '更新时间',
                                  `is_deleted` string COMMENT '删除标记（0:不可用 1:可用）'
) partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/user/hive/warehouse/dev_realtime_tms01_xinnuo_zhao.db/hivetablename/ods/ods_base_organ'
tblproperties ("parquet.compression"="gzip");
load data inpath "/2207A/zhaoxinnuo/tms/base_organ/2025-03-24/"
into table ods_base_organ partition (dt='2025-03-24');
select * from ods_base_organ;

-- dwd
drop table dwd_order_info;
CREATE TABLE `dwd_order_info` (
                                  `id` int COMMENT 'id',
                                  `order_no` string COMMENT '订单号',
                                  `status` string COMMENT '订单状态',
                                  `collect_type` string COMMENT '取件类型，1为网点自寄，2为上门取件',
                                  `user_id` int COMMENT '客户id',
                                  `receiver_complex_id` int COMMENT '收件人小区id',
                                  `receiver_province_id` string COMMENT '收件人省份id',
                                  `receiver_city_id` string COMMENT '收件人城市id',
                                  `receiver_district_id` string COMMENT '收件人区县id',
                                  `receiver_address` string COMMENT '收件人详细地址',
                                  `receiver_name` string COMMENT '收件人姓名',
                                  `receiver_phone` string COMMENT '收件人电话',
                                  `receive_location` string COMMENT '起始点经纬度',
                                  `sender_complex_id` int COMMENT '发件人小区id',
                                  `sender_province_id` string COMMENT '发件人省份id',
                                  `sender_city_id` string COMMENT '发件人城市id',
                                  `sender_district_id` string COMMENT '发件人区县id',
                                  `sender_address` string COMMENT '发件人详细地址',
                                  `sender_name` string COMMENT '发件人姓名',
                                  `sender_phone` string COMMENT '发件人电话',
                                  `send_location` string COMMENT '发件人坐标',
                                  `payment_type` string COMMENT '支付方式',
                                  `cargo_num` int COMMENT '货物个数',
                                  `amount` decimal(32,2) COMMENT '金额',
                                  `estimate_arrive_time` date COMMENT '预计到达时间',
                                  `distance` decimal(10,2) COMMENT '距离，单位：公里',
                                  `create_time` timestamp COMMENT '创建时间',
                                  `update_time` timestamp COMMENT '更新时间',
                                  `is_deleted` string COMMENT '删除标记（0:不可用 1:可用）'
) partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/user/hive/warehouse/dev_realtime_tms01_xinnuo_zhao.db/hivetablename/dwd/dwd_order_info'
tblproperties ("parquet.compression"="gzip");
set hive.exec.dynamic.partition.mode=nonstrict;
insert  overwrite table  dwd_order_info partition(dt )
select  * from ods_order_info
where dt='2025-03-24'  and id is not null;
select * from dwd_order_info;


-- 运单明细表
drop table dwd_order_cargo;
CREATE TABLE `dwd_order_cargo` (
                                   id            bigint ,
                                   order_id      string         comment '订单id',
                                   cargo_type    string comment '货物类型id',
                                   volume_length int                     comment '长cm',
                                   volume_width  int                     comment '宽cm',
                                   volume_height int                      comment '高cm',
                                   weight        decimal(16, 2)          comment '重量 kg',
                                   remark        string                 comment '备注',
                                   create_time   string             comment '创建时间',
                                   update_time   string            comment '更新时间',
                                   is_deleted    string comment '删除标记（0:不可用 1:可用）'
)partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/user/hive/warehouse/dev_realtime_tms01_xinnuo_zhao.db/hivetablename/dwd/dwd_order_cargo'
tblproperties ("parquet.compression"="snappy");
set hive.exec.dynamic.partition.mode=nonstrict;
insert  overwrite table  dwd_order_cargo partition(dt )
select  * from ods_order_cargo
where dt='2025-03-24'  and id is not null;
select * from dwd_order_cargo;


-- 字典表
drop table dwd_base_dic;
CREATE TABLE `dwd_base_dic` (
                                `id` int COMMENT 'id',
                                `parent_id` string COMMENT '上级id',
                                `name` string COMMENT '名称',
                                `dict_code` string COMMENT '编码',
                                `create_time` timestamp COMMENT '创建时间',
                                `update_time` timestamp COMMENT '更新时间',
                                `is_deleted` string COMMENT '删除标记（0:不可用 1:可用）'
)partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/user/hive/warehouse/dev_realtime_tms01_xinnuo_zhao.db/hivetablename/dwd/dwd_base_dic'
tblproperties ("parquet.compression"="gzip");
set hive.exec.dynamic.partition.mode=nonstrict;
insert  overwrite table  dwd_base_dic partition(dt )
select  * from ods_base_dic
where dt='2025-03-24'  and id is not null;
select * from dwd_base_dic;


-- 小区表
drop table dwd_base_complex;
CREATE TABLE `dwd_base_complex` (
                                    `id` int,
                                    `complex_name` string,
                                    `province_id` string,
                                    `city_id` string,
                                    `district_id` string,
                                    `district_name` string,
                                    `create_time` string ,
                                    `update_time` string,
                                    `is_deleted` string
)partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/user/hive/warehouse/dev_realtime_tms01_xinnuo_zhao.db/hivetablename/dwd/dwd_base_complex'
tblproperties ("parquet.compression"="gzip");
set hive.exec.dynamic.partition.mode=nonstrict;
insert  overwrite table  dwd_base_complex partition(dt )
select  * from ods_base_complex
where dt='2025-03-24'  and id is not null;
select * from dwd_base_complex;


-- 地区表
drop table dwd_base_region_info;
CREATE TABLE `dwd_base_region_info` (
                                        id          bigint               comment 'id',
                                        parent_id   string               comment '上级id',
                                        name        string               comment '名称',
                                        dict_code   string               comment '编码',
                                        short_name  string               comment '简称',
                                        create_time string               comment '创建时间',
                                        update_time string               comment '更新时间',
                                        is_deleted  string               comment '删除标记（0:不可用 1:可用）'
) partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/user/hive/warehouse/dev_realtime_tms01_xinnuo_zhao.db/hivetablename/dwd/dwd_base_region_info'
tblproperties ("parquet.compression"="gzip");
set hive.exec.dynamic.partition.mode=nonstrict;
insert  overwrite table  dwd_base_region_info partition(dt )
select  * from ods_base_region_info
where dt='2025-03-24'  and id is not null;
select * from dwd_base_region_info;


-- 机构表
CREATE TABLE `dwd_base_organ` (
                                  `id` int,
                                  `org_name` string COMMENT '机构名称',
                                  `org_level` string COMMENT '行政级别',
                                  `region_id` string COMMENT '区域id，1级机构为city ,2级机构为district',
                                  `org_parent_id` string COMMENT '上级机构id',
                                  `points` string COMMENT '多边形经纬度坐标集合',
                                  `create_time` string COMMENT '创建时间',
                                  `update_time` string COMMENT '更新时间',
                                  `is_deleted` string COMMENT '删除标记（0:不可用 1:可用）'
) partitioned by (dt string)
row format delimited fields terminated by '\t'
location '/user/hive/warehouse/dev_realtime_tms01_xinnuo_zhao.db/hivetablename/dwd/dwd_base_organ'
tblproperties ("parquet.compression"="gzip");
set hive.exec.dynamic.partition.mode=nonstrict;
insert  overwrite table  dwd_base_organ partition(dt )
select  * from ods_base_organ
where dt='2025-03-24'  and id is not null;
select * from dwd_base_organ;



drop table dws_cargo_order_daily1_sum;
CREATE TABLE dws_cargo_order_daily1_sum (

                                            cargo_type        string COMMENT '货物类型',
                                            receiver_city     string COMMENT '收件人城市（区域）',
                                            collect_type      string COMMENT '取件类型',
                                            order_count       bigint COMMENT '下单数',
                                            amount_sum        decimal(32, 2) COMMENT '下单金额总和'
) COMMENT '最近1日数据汇总表'
PARTITIONED BY (`dt` string)
STORED AS PARQUET
LOCATION '/2207A/chenming/tms/dws/dws_cargo_order_daily_sum/'
TBLPROPERTIES (
    "compression"="lzo"
);
set hive.exec.dynamic.partition.mode=nonstrict;
insert into dws_cargo_order_daily1_sum partition (dt='2025-03-24')
select
    cargo_type,
    receiver_city,
    collect_type ,
    order_count,
    amount_sum

from (select cargo_type,
             fo.name as receiver_city,
             collect_type,
             count(distinct ia.id) as order_count,
             sum(amount * cargo_num)  amount_sum,
             fo.dt

      from ods_order_info ia
               left join ods_order_cargo c on ia.id = c.order_id
               left join dwd_base_dic cc on c.cargo_type = cc.id
               left join dwd_base_region_info fo on ia.receiver_city_id = fo.id
      where c.dt ='2025-03-24' and cc.dt='2025-03-24' and fo.dt='2025-03-24'
      group by cargo_type,fo.name,collect_type,fo.dt
     )a
where a.dt ='2025-03-24';

create database hive_xinnuo_zhao;
use hive_xinnuo_zhao;
drop table base_region;
create table ods_order_info
(
    id           string comment '编号',
    total_amount decimal(16, 2) comment '总金额',
    order_status string comment '订单状态',
    user_id      string comment '用户id',
    payment_way  string comment '订单备注',
    out_trade_no string comment '订单交易编号（第三方支付用)',
    create_time  string comment '创建时间',
    operate_time string comment '操作时间'
) comment '订单表 订单表';
-- dev_realtime_g1_xinnuo_zhao

create table base_region
(
    id          string comment '大区id',
    region_name string comment '大区名称'
);

