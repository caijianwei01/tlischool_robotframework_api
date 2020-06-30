*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           String
Library           HttpLibrary.HTTP

*** Keywords ***
_Post_Request
    [Arguments]    ${host}    ${path}    ${data}=None    ${json}=None    ${params}=None    ${headers}=None    ${cookies}=None    ${timeout}=30
    [Documentation]    发送post请求
    ...    ${host}：请求域名
    ...    ${path}：请求路径
    ...    ${datas}：post请求数据
    ...    ${params}：请求参数字符串，默认设置为空
    ...    ${headers}：请求头，默认设置为空
    ...    ${cookies}：请求cookie，默认为空
    ...    ${timeout}：请求超时时间，默认是30秒
    #处理header
    ${header_dict}    Create Dictionary    Content-Type=application/json
    Run Keyword If    ${headers}==None    Log    没有添加自定义header
    ...    ELSE    Run Keyword    add_header    ${headers}    ${header_dict}
    #处理cookies
    ${cookie_dict}    Create Dictionary
    Run Keyword If    ${cookies}==None    Log    没有添加cookie信息
    ...    ELSE    Run Keyword    add_cookie    ${cookies}    ${cookie_dict}
    #创建session
    Create Session    api    ${host}    cookies=${cookie_dict}    timeout=${timeout}
    #发起post请求
    ${resp}    RequestsLibrary.Post Request    api    ${path}    data=${data}    json=${json}    params=${params}    headers=${headers}    timeout=${timeout}
    [Return]    ${resp}

_Get_Request
    [Arguments]    ${host}    ${path}    ${data}=None    ${json}=None    ${params}=None    ${headers}=None    ${cookies}=None    ${timeout}=30
    [Documentation]    发送get请求
    ...    ${host}：请求域名
    ...    ${path}：请求路径
    ...    ${datas}：post请求数据
    ...    ${params}：请求参数字符串，默认设置为空
    ...    ${headers}：请求头，默认设置为空
    ...    ${cookies}：请求cookie，默认为空
    ...    ${timeout}：请求超时时间，默认是30秒
    #处理header
    ${header_dict}    Create Dictionary    Content-Type=application/json
    Run Keyword If    ${headers}==None    Log    没有添加自定义header
    ...    ELSE    Run Keyword    add_header    ${headers}    ${header_dict}
    #处理cookies
    ${cookie_dict}    Create Dictionary
    Run Keyword If    ${cookies}==None    Log    没有添加cookie信息
    ...    ELSE    Run Keyword    add_cookie    ${cookies}    ${cookie_dict}
    #创建session
    Create Session    api    ${host}    cookies=${cookie_dict}    timeout=${timeout}
    #发起get请求
    ${resp}    RequestsLibrary.Get Request    api    ${path}    data=${data}    json=${json}    params=${params}    headers=${headers}    timeout=${timeout}
    [Return]    ${resp}

add_header
    [Arguments]    ${dict1}    ${dict2}
    [Documentation]    遍历字典变量dict1，并将dict1中的值添加到dict2中
    Log    在请求中添加自定义header
    @{dict1_keys}    Get Dictionary Keys    ${dict1}
    FOR    ${key}    IN    @{dict1_keys}
        Set To Dictionary    ${dict2}    ${key}=${dict1}[${key}]
    END

add_cookie
    [Arguments]    ${cookies}    ${cookie_dict}
    [Documentation]    处理cookie, 将字符串的cookies拆解添加到cookie_dcit字典中
    @{cookie_list}    Split String    ${cookies}    ;
    FOR    ${cookie}    IN    @{cookie_list}
        Run Keyword If    '${cookie}'=='${None}'    Exit For Loop    #如果cookie为None,则跳出循环体
        @{cookie_split}    Split String    ${cookie}    =
        Set To Dictionary    ${cookie_dict}    ${cookie_split}[0]=${cookie_split}[1]
    END
