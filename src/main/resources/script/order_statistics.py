#!/usr/bin/python
#coding=utf-8
################################################################################
#
# wpdrc
#
################################################################################
"""
订单统计脚本

Authors: liubaoyu
Date:    2018/3/19
"""
import sys
from common import logger_util
import os
import time
import MySQLdb

LOGGER = None
DB = None
CURSOR = None

CURR_TIME = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(time.time()))

def getStatisticsDay():
    curr_date = time.strftime('%Y-%m-%d', time.localtime(time.time()))
    
    #读取day文件确定分析的日期
    if os.path.isfile('day'):
        day_file = open('day', 'r')
        day_date = day_file.read().strip('\n')
        day_file.close()
        if day_date == curr_date:
            return [curr_date]
        else:
            return [day_date, curr_date]
    else:
        #创建、将当前date写入    
        day_file = open('day', 'w')
        day_file.write(curr_date)
        day_file.flush()
        day_file.close()
        return [curr_date]

def initDb():
    global DB
    DB = MySQLdb.connect("localhost","root","123456","wpdrc",charset="utf8")
    global CURSOR
    CURSOR = DB.cursor()

def statistics(day):
    if DB is None:
        initDb()

    #统计总体销售信息
    CURSOR.execute('select count(1), sum(if(o.order_type = \'堂食\', 1, 0)), sum(if(o.order_type = \'打包\', 1, 0)), sum((select sum(product_price * product_num) from tb_order_detail_history where order_id = o.id))' + \
    ' from tb_order_history o where (o.status_str = \'已买单\' or o.status_str = \'已付款已取货\') and DATE_FORMAT(o.create_time, \'%Y-%m-%d\') = \'' + day + '\' and o.create_time <= \'' + CURR_TIME + '\'')
    data = CURSOR.fetchone()
    if data is not None:
    	CURSOR.execute('delete from tb_order_report_day where day = \'' + day + '\'')
    	CURSOR.execute('insert into tb_order_report_day values(' + '\'' + day + '\',' + ('0' if data[3] is None else str(data[3])) + ',' + str(data[0]) + ',' + ('0' if data[1] is None else str(data[1])) + ',' + ('0' if data[2] is None else str(data[2])) + ')')

    #统计商品销售信息
    CURSOR.execute('select d.product_name, sum(d.product_num), sum(d.product_price * d.product_num) from tb_order_history o left outer join tb_order_detail_history d on o.id = d.order_id where (o.status_str = \'已买单\' or o.status_str = \'已付款已取货\') and DATE_FORMAT(o.create_time, \'%Y-%m-%d\') = \'' + day + '\' and o.create_time <= \'' + CURR_TIME + '\'' + \
    ' group by d.product_name')
    data = CURSOR.fetchall()
    if data is not None:
    	for d in data:
        	CURSOR.execute('delete from tb_order_detail_report_day where day = \'' + day + '\'' + ' and product_name = \'' + d[0] + '\'')
        	CURSOR.execute('insert into tb_order_detail_report_day values(\'' + day + '\',\'' + d[0] + '\',' + str(d[1]) + ',' + str(d[2]) + ')')
    DB.commit()

if __name__ == '__main__':
    try:
        LOGGER = logger_util.get_logger('order_statistics', 'order_statistics.log')
        LOGGER.info('order statistics begin=====')
        days = getStatisticsDay()
        for day in days:
            statistics(day)

        LOGGER.info('order statistics success=====')
        if len(days) == 2:
        	LOGGER.info('write day file begin=====')    
        	day_file = open('day', 'w')
        	day_file.write(days[1])
        	day_file.flush()
        	day_file.close()
        	LOGGER.info('write day file success=====')
        	
        sys.exit(0)
    except Exception as e:
        LOGGER.error(e)
        LOGGER.info('order statistics error=====')
        sys.exit(1)
    finally:
        if(CURSOR is not None):
            CURSOR.close()
        if(DB is not None):
            DB.close()
        