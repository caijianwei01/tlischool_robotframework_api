#!/usr/bin/env python
# -*- coding:utf-8 -*-
from verification_library.attendance_util import AttendanceUtil
from verification_library.version import VERSION

__version__ = VERSION


class verification_library(AttendanceUtil):
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
