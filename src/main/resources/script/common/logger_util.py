#!/usr/bin/python
# coding=utf-8
################################################################################
#
# wpdrc
#
################################################################################
"""
日志工具

Authors: liubaoyu
Date:    2018/3/19
"""

import logging
import sys
from logging.handlers import TimedRotatingFileHandler
import os

def get_logger(log_name, log_file_name):
    if not os.path.exists('./log'):
        os.mkdir('./log')
    logger = logging.getLogger(log_name)
    timed_rotating_file_handler = TimedRotatingFileHandler('./log/' + log_file_name, when='D', interval=1, backupCount=7)
    formatter = logging.Formatter('[%(asctime)s][%(levelname)s][%(name)s:%(lineno)d] %(message)s')
    timed_rotating_file_handler.setFormatter(formatter)
    logger.addHandler(timed_rotating_file_handler)

    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.formatter = formatter
    logger.addHandler(console_handler)
    logger.setLevel(logging.INFO)
    return logger
