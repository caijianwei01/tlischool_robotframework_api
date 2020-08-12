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

    def verfication_data(self, data):
        """
        1、验证传入的参数，如果为字典，则遍历字典中的各个key，判断各个key值；如果为字符串，则校验字符串为非空；如果为整数，
        则校验值大于0
        2、如果传入的参数为列表，则将列表中的各个参数取出；如果列表中的各个参数为字典，处理方法参照第1步
        :param data: 传入的数据
        :return:
        """
        if isinstance(data, dict):
            logger.info("---基本信息获取---")
            logger.info("传入的data为json对象！")
            logger.info(f"传入过来的JSON对象主key的长度：{len(data)}")
            keys = data.keys()
            logger.info(keys)
            logger.info("---开始进行校验---")
            # 定义变量，计算遍历次数
            times = 0
            for key, value in data.items():
                times += 1
                logger.info("")
                logger.info(f"---传入的data数据，第{times}个对象元素，key值对应为：{key}")
                logger.info(f"{key}：{value}")
                self.analysis_subItem(value)
        else:
            logger.info("传入的数据不是dict对象")

    def analysis_subItem(self, item):
        """
        判断item值对应的类型，从而进行相应的处理，嵌入递归函数
        不管item值取出如何，最终还是拆解成最小单元，按字符串或者整型来进行判断
        :param item:
        :param msg:
        :return:
        """
        if isinstance(item, str):
            if len(item) == 0:
                raise AssertionError(f"str类型不能为空！")
        elif isinstance(item, int):
            if int(item) <= 0:
                raise AssertionError(f"int类型取值需大于等于0！")
        elif isinstance(item, list):
            logger.info(f"{item}对应值的类型为list且长度为{len(item)}")
            for i in range(len(item)):
                logger.info("")
                logger.info(f"内嵌的列表中，第{i + 1}个元素")
                self.analysis_subItem(item[i])
        elif isinstance(item, dict):
            logger.info(f"{item}对应值的类型为dict且长度为{len(item)}")
            times = 0
            for key, value in item.items():
                times += 1
                logger.info("")
                logger.info(f"---内嵌的字典中，第{times}个对象元素，key值对应为：{key}")
                logger.info(f"{key}：{value}")
                self.analysis_subItem(value)
