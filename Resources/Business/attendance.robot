*** Settings ***
Resource          ../Public/http_request.robot
Variables         ../Lib/attendance/config.py

*** Variables ***

*** Keywords ***
request_get
    [Arguments]    ${host}    ${path}    ${data}=None    ${json}=None    ${params}=None    ${headers}=None    ${cookies}=None
    ${resp}    _Get_Request    ${host}    ${path}    data=${data}    json=${json}    params=${params}    headers=${headers}    cookies=${cookies}
    [Return]    ${resp}

request_post
    [Arguments]    ${host}    ${path}    ${data}=None    ${json}=None    ${params}=None    ${headers}=None    ${cookies}=None
    ${resp}    _Post_Request    ${host}    ${path}    data=${data}    json=${json}    params=${params}    headers=${headers}    cookies=${cookies}
    [Return]    ${resp}
