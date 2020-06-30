#!/usr/bin/env python
# -*- coding:utf-8 -*-
import time
import hashlib
import json
import requests


class AttendanceUtil(object):
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    ROBOT_LIBRARY_VERSION = 0.1
    ROBOT_LIBRARY_DOC_FORMAT = 'reST'

    @staticmethod
    def calculate_sign():
        """
        获取md5加密签名
        :return: 返回签名
        """
        timestamp = str(int(time.time()))
        app_secret, app_key = "47F9B660196F0F23B55908786E8A327B", "E1B559D014E90F7EF8047949A7440F3E"
        md5_val = hashlib.md5((app_key + str(timestamp) + app_secret).lower().encode("utf-8")).hexdigest()
        return md5_val

    def app_auth(self, host, path):
        """
        获取token
        :param host:请求域名
        :param path:请求路径
        :return: 返回token
        """
        url = host + path
        data = {
            'app_id': '15676497800668552d',
            'app_key': 'E1B559D014E90F7EF8047949A7440F3E',
            'timestamp': str(int(time.time())),
            'sign': self.calculate_sign()
        }
        rs = requests.post(url, data=json.dumps(data))
        return rs.json()['data']

    @staticmethod
    def get_timestamp():
        """
        获取时间戳
        :return: 返回时间戳
        """
        timestamp = str(int(time.time()))
        return timestamp
