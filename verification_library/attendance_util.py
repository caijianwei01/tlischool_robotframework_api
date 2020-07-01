#!/usr/bin/env python
# -*- coding:utf-8 -*-
import time
import hashlib
import requests


class AttendanceUtil(object):

    def calculate_sign(self):
        """
        获取md5加密签名
        :return: 返回签名
        """
        timestamp = self.get_timestamp()
        app_secret, app_key = "47F9B660196F0F23B55908786E8A327B", "E1B559D014E90F7EF8047949A7440F3E"
        md5_val = hashlib.md5((app_key + timestamp + app_secret).lower().encode("utf-8")).hexdigest()
        return md5_val, timestamp

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
            'timestamp': self.get_timestamp(),
            'sign': self.calculate_sign()
        }
        rs = requests.post(url, json=data)
        return rs.json()['data']

    def get_timestamp(self):
        """
        获取时间戳
        :return: 返回时间戳
        """
        timestamp = str(round(time.time() * 1000))
        return timestamp


if __name__ == '__main__':
    host = 'http://attendance.yooticloud.cn/api/v1/'
    path = 'app/auth'
    au = AttendanceUtil()
    token = au.app_auth(host, path)
    print(token)
