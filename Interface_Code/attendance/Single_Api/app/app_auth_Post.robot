*** Settings ***
Resource          ../../../../Resources/Business/attendance.robot
Library           verification_library

*** Test Cases ***
Class_01_app鉴权
    [Setup]
    [Template]    app_auth_assertClass
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
    ${timestamp}    Set Variable If    ${timestamp}==None    ${sign1}[-1]
    ${sign}    Set Variable If    ${sign}==None    ${sign1}[0]
    Set To Dictionary    ${datas}    app_id=${app_id}
    Set To Dictionary    ${datas}    app_key=${app_key}
    Set To Dictionary    ${datas}    timestamp=${timestamp}
    Set To Dictionary    ${datas}    sign=${sign}
    Log    ${datas}
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
    [Arguments]    ${app_id}    ${app_key}    ${timestamp}=None    ${sign}=None
    [Documentation]    app鉴权：校验异常场景的业务逻辑
    ...    app_id: 项目id
    ...    app_key: 项目的密钥
    ...    timestamp：时间戳
    ...    sign：加密签名
    ${resp}    app_auth_Post    ${app_id}    ${app_key}    timestamp=${timestamp}    sign=${sign}
    Should Be True    ${resp}[code]==-1

app_auth_assertDataVerify
    [Arguments]    ${app_id}    ${app_key}    ${timestamp}=None    ${sign}=None
    [Documentation]    app鉴权：校验接口业务返回数据是否正确
    ...    app_id: 项目id
    ...    app_key: 项目的密钥
    ...    timestamp：时间戳
    ...    sign：加密签名
    ${resp}    app_auth_Post    ${app_id}    ${app_key}    timestamp=${timestamp}    sign=${sign}
    Should Be True    ${resp}[code]==-1
