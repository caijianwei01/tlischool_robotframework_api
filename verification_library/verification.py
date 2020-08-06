#!/usr/bin/env python
# -*- coding:utf-8 -*-
from robot.api import logger


class Verfication(object):
    def get_listcmp(self, data_list):
        """
        判断列表升降序，升序返回True，降序返回False
        :param data_list:
        :return:
        """
        return all(x < y for x, y in zip(data_list, data_list[1:]))

    def verfication_data(self, data, msg=None):
        """
        1、验证传入的参数，如果为字典，则遍历字典中的各个key，判断各个key值；如果为字符串，则校验字符串为非空；如果为整数，
        则校验值大于0
        2、如果传入的参数为列表，则将列表中的各个参数取出；如果列表中的各个参数为字典，处理方法参照第1步
        :param data:
        :param msg:
        :return:
        """
        if isinstance(data, dict):
            pass
