#!/usr/bin/env python
# -*- coding:utf-8 -*-
"""
考勤平台常量
"""
__all__ = ["URL", "AUTH_PERSON", "CANCEL_AUTH_PERSON", "DEVICE_INTERACTIVE", "AUTH", "QUERY_USER_INFO", "PROVIDER_USER",
           "AUTH_LIST",
           "DEVICE", "UPLOAD_FILE", "TY_CW", "ZF_CW", "WO_CW", "WT_CW", "YSK", "WO_RL", "WT_RL", "SCHOOL_ID",
           "SCHOOL_KEY"]
URL = "http://attendance.yooticloud.cn/api/v1"
# URL = "http://attendance.yooticloud.yt/api/v1"
# URL = "http://192.168.1.25:8081"

# 设备授权人员
AUTH_PERSON = "provider/device/auth_person"
# 设备销权人员
CANCEL_AUTH_PERSON = "provider/device/cancel_auth_person"
# 远程开门
DEVICE_INTERACTIVE = "provider/device/device_interactive"
# APP鉴权
AUTH = "app/auth"
# 根据guid获取人员姓名和图片地址
QUERY_USER_INFO = "provider/user/query_user_info"
# 新增考勤人员
PROVIDER_USER = "provider/user"
# 查询设备下授权异常人员
AUTH_LIST = "provider/user_device/auth_list?"
# 查询正非设备某个版本下的设备
DEVICE = "provider/device?"
# 文件上传
UPLOAD_FILE = "upload_file"

# TY_智慧校园测温专用
TY_CW = "1587793700717"
# F_智慧校园平板型测温设备
ZF_CW = "1586148163543"
# W_校园测温应用
WO_CW = "1583737727896"
# T_智慧校园测温专用
WT_CW = "1583484992673"
# Y_云识客
YSK = "3001"
# W_智慧校园
WO_RL = "2001"
# T_智慧校园
WT_RL = "1500"

# 学校项目ID
SCHOOL_ID = "15676497800668552d"
# 学校项目KEY
SCHOOL_KEY = "E1B559D014E90F7EF8047949A7440F3E"
