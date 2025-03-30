-- # 订单表
CREATE TABLE ods_orders_info (
                                 order_id int,
                                 customer_id int ,
                                 order_date string,
                                 total_amount DECIMAL(10,2),
                                 payment_method string,
                                 shipping_address string,
                                 order_status string,
                                 created_at string,
                                 updated_at string
);
select * from ods_orders_info;
-- # 支付表
CREATE TABLE ods_payments_info (
                                   payment_id int,
                                   order_id int,
                                   payment_date string,
                                   amount DECIMAL(10,2) ,
                                   payment_method string,
                                   payment_status string,
                                   transaction_id string,
                                   created_at string
);

-- # 用户表
CREATE TABLE ods_users_info (
                                user_id int,
                                username string,
                                email string,
                                password_hash string,
                                first_name string,
                                last_name string,
                                gender string,
                                birth_date string,
                                phone_number string,
                                address string,
                                city string,
                                state string,
                                country string,
                                postal_code string,
                                registration_date string,
                                last_login string,
                                account_status string,
                                user_role string,
                                created_at string,
                                updated_at string
);
-- # 商铺表
CREATE TABLE ods_shops (
                           shop_id int,
                           shop_name string,
                           owner_id int,
                           description int,
                           contact_email string,
                           contact_phone string,
                           address string,
                           city string,
                           state string,
                           country string,
                           postal_code string,
                           latitude DECIMAL(10,8),
                           longitude DECIMAL(11,8),
                           business_hours string,
                           average_rating DECIMAL(3,2),
                           total_reviews int,
                           category string,
                           created_at string,
                           updated_at string,
                           status string
);

-- 创建用户行为表
CREATE TABLE ods_user_behavior (
                                   behavior_id int,
                                   user_id int,
                                   behavior_type string,
                                   behavior_time string,
                                   target_id string
);

CREATE TABLE ods_categories (
                                category_id int,
                                category_name string,
                                parent_id int,
                                level string,
                                created_at string
);

CREATE TABLE ods_products (
                              product_id int,
                              shop_id INT ,
                              product_name string,
                              category_id INT ,
                              price DECIMAL(10,2),
                              cost DECIMAL(10,2),
                              stock_quantity INT,
                              sales_volume INT,
                              description string,
                              main_image_url string,
                              status string,
                              created_at string,
                              updated_at string
);

-- -- 全量快照 day更新 每天，每个店铺的每个商品的详情指标统计 source -> ods -> dws
create table dws_store_anys_info_1df(
                                        product_no string comment '价格带（100-500,501-1000,1000-5000,>5000）',
                                        product_name string comment'商品名称' ,
                                        store_no string comment '',
                                        product_num_uv int comment '商品访客数（uv）',
                                        product_num_pv int  comment '商品浏览量(pv)',
                                        have_product_num int comment '有访问的商品数',
                                        product_stopover_avg_ts string comment '商品平均停留时长',
                                        product_info_page_jump_rate DECIMAL(16,2) comment '商品详情页跳出率',
                                        product_trove_num int comment '商品收藏人数',
                                        cart_item_count int comment '商品加购件数',
                                        cart_user_count int comment '商品加购人数',
                                        product_trove_rate DECIMAL(16,2) comment '访问收藏转化率',
                                        cart_conven_rate DECIMAL(16,2) comment '访问加购转化率',
                                        order_user_count int comment '下单买家数',
                                        order_item_count int comment '下单件数',
                                        order_amount DECIMAL(16,2) comment '下单金额',
                                        order_rate DECIMAL(16,2) comment '下单转化率',
                                        payment_buyuser_count int comment '支付买家数',
                                        payment_item_count int comment '支付件数',
                                        payment_amount DECIMAL(16,2) comment '支付金额',
                                        have_payment_product_count int comment '有支付商品数',
                                        payment_rate DECIMAL(16,2) comment '支付转化率',
                                        payment_new_user_count int comment '支付新买家数',
                                        payment_old_user_count int comment '支付老买家数',
                                        old_user_payment_amount DECIMAL(16,2) comment '老买家支付金额',
                                        unit_price decimal(16,2) comment '客单价',
                                        refund_amount DECIMAL(16,2) comment '成功退款退货金额',
                                        payment_year_amount DECIMAL(16,2) comment '年累计支付金额',
                                        visit_value DECIMAL(16,2) comment '访客平均价值',
                                        pk_score DECIMAL(16,2) comment '竞争力评分',
                                        product_visit_count int comment '商品微详情访客数'

);
-- INSERT OVERWRITE TABLE dws_store_anys_info_1df PARTITION(dt='2025-03-29')
select
from dws_store_anys_info_1df left join ods_products op on dws_store_anys_info_1df.product_name = op.product_name
                             left join ods_categories oc on op.category_id = oc.category_id
                             left join ods_orders_info ooi on oc.created_at = ooi.created_at
                             left join ods_payments_info opi on ooi.order_id = opi.order_id
                             left join ods_shops os on op.description = os.description
                             left join ods_users_info oui on oc.created_at = oui.created_at
                             left join ods_user_behavior oub on oui.user_id = oub.user_id;