#!/usr/bin/env python
# -*- coding:utf-8 -*-
from verification_library.attendance_util import AttendanceUtil
from verification_library.mysql_util import MysqlUtil
from verification_library.myutils import MyUtils
from verification_library.version import VERSION

__version__ = VERSION


class verification_library(AttendanceUtil, MysqlUtil, MyUtils):
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
