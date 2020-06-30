*** Settings ***
Resource          ../../../../Resources/Business/attendance.robot
Library           verification_library

*** Test Cases ***
test
    ${resp}    Calculate Sign
    log    ${resp}
    log    ${resp}[-1]

Class_01_app鉴权
    [Setup]
    [Template]    app_auth_Post
    15676497800668552d    E1B559D014E90F7EF8047949A7440F3E

*** Keywords ***
app_auth_Post
    [Arguments]    ${app_id}    ${app_key}    ${timestamp}=None    ${sign}=None
    [Documentation]    app鉴权：获取token
    ...    app_id: \ 项目id
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
    ${resp}    request_post    ${url}    ${attendanceApi}[appAuth]    json=${datas}
    #将响应数据从字符串转成python字典对象
    Should Be True    ${resp.json()}[code]==1
