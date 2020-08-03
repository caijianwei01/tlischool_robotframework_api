*** Settings ***
Resource          ../../../../Resources/Business/attendance.robot

*** Test Cases ***
Class_01_获取token
    [Tags]    true
    [Setup]
    [Template]    app_auth_assertClass
    ${SCHOOL_ID}    ${SCHOOL_KEY}

Exception_02_获取token项目ID错误
    [Tags]    false
    [Template]    app_auth_assertException
    15676497800668552c    ${SCHOOL_KEY}    应用不存在

Exception_03_获取token项目KEY错误
    [Tags]    false
    [Template]    app_auth_assertException
    ${SCHOOL_ID}    E1B559D014E90F7EF8047949A7440F3F    俩次签名对比失败

Exception_04_获取token时间戳不一致
    [Tags]    false
    [Template]    app_auth_assertException
    ${SCHOOL_ID}    ${SCHOOL_KEY}    俩次签名对比失败    1593616102577

Exception_05_获取token签名不一致
    [Tags]    false
    [Template]    app_auth_assertException
    ${SCHOOL_ID}    ${SCHOOL_KEY}    俩次签名对比失败    ${None}    a123

DataVerify_06_关键字段校验不为空
    [Template]    app_auth_assertDataVerify
    ${SCHOOL_ID}    ${SCHOOL_KEY}

*** Keywords ***
app_auth_Post
    [Arguments]    ${app_id}    ${app_key}    ${timestamp}=None    ${sign}=None
    [Documentation]    app鉴权：校验接口服务的连通性
    ...    app_id: 项目id
    ...    app_key: 项目的密钥
    ...    timestamp：时间戳
    ...    sign：加密签名
    ${datas}    Create Dictionary
    ${sign1}    Calculate Sign    #获取签名
    #如果值为空就赋值第一个，不为空就使用传进来的值
    ${timestamp}    Set Variable If    ${timestamp}==None    ${sign1}[-1]    ${timestamp}
    ${sign}    Set Variable If    ${sign}==None    ${sign1}[0]    ${sign}
    Set To Dictionary    ${datas}    app_id=${app_id}
    Set To Dictionary    ${datas}    app_key=${app_key}
    Set To Dictionary    ${datas}    timestamp=${timestamp}
    Set To Dictionary    ${datas}    sign=${sign}
    ${resp}    request_post    ${URL}    ${AUTH}    json=${datas}
    Should Be True    ${resp.status_code}==200
    [Return]    ${resp.json()}    # 返回json结果

app_auth_assertClass
    [Arguments]    ${app_id}    ${app_key}    ${timestamp}=None    ${sign}=None
    [Documentation]    app鉴权：校验正常场景的业务逻辑
    ...    app_id: 项目id
    ...    app_key: 项目的密钥
    ...    timestamp：时间戳
    ...    sign：加密签名
    ${resp}    app_auth_Post    ${app_id}    ${app_key}    timestamp=${timestamp}    sign=${sign}
    Should Be True    ${resp}[code]==1

app_auth_assertException
    [Arguments]    ${app_id}    ${app_key}    ${error_msg}    ${timestamp}=None    ${sign}=None
    [Documentation]    app鉴权：校验异常场景的业务逻辑
    ...    app_id: 项目id
    ...    app_key: 项目的密钥
    ...    error_msg:错误信息
    ...    timestamp：时间戳
    ...    sign：加密签名
    ${resp}    app_auth_Post    ${app_id}    ${app_key}    timestamp=${timestamp}    sign=${sign}
    Should Be True    ${resp}[code]==-1
    Should Contain    ${resp}[msg]    ${error_msg}

app_auth_assertDataVerify
    [Arguments]    ${app_id}    ${app_key}    ${timestamp}=None    ${sign}=None
    [Documentation]    app鉴权：校验接口业务返回数据是否正确
    ...    app_id: 项目id
    ...    app_key: 项目的密钥
    ...    timestamp：时间戳
    ...    sign：加密签名
    ${resp}    app_auth_Post    ${app_id}    ${app_key}    timestamp=${timestamp}    sign=${sign}
    Should Be True    ${resp}[code]==1
    #验证关键字段的返回值不能为空
    Should Not Be Empty    ${resp}[data]
    Should Not Be Empty    ${resp}[msg]
