*** Settings ***
Resource          ../../../../Resources/Business/attendance.robot

*** Test Cases ***
Class_01_设备授权人员
    [Template]    auth_person_assertClass
    5C04R080180    1594795026198

Exception_02_设备序列号为空
    [Template]    auth_person_assertException
    ${None}    1594795026198    10701    设备序列号必须添加

Exception_03_授权人员为空
    [Template]    auth_person_assertException
    5C04R080180     ${None}    10706    人员编号必须添加

*** Keywords ***
auth_person_Post
    [Arguments]    ${seq_no}    ${guids}
    ${datas}    Create Dictionary
    ${headers}    Create Dictionary
    ${token}    get_token
    Set To Dictionary    ${headers}    token=${token}
    Set To Dictionary    ${datas}    seq_no=${seq_no}
    Set To Dictionary    ${datas}    guids=${guids}
    ${resp}    request_post    ${URL}    ${AUTH_PERSON}    headers=${headers}    json=${datas}
    Should Be True    ${resp.status_code}==200
    [Return]    ${resp.json()}

auth_person_assertClass
    [Arguments]    ${seq_no}    ${guids}
    ${resp}    auth_person_Post    ${seq_no}    ${guids}
    Should Be True    ${resp}[code]==1

auth_person_assertException
    [Arguments]    ${seq_no}    ${guids}    ${errorCode}    ${errorMessage}
    ${resp}    auth_person_Post    ${seq_no}    ${guids}
    Should Be True    ${resp}[code]==${errorCode}
    Should Contain    ${resp}[msg]    ${errorMessage}

auth_person_DataVerify
    [Arguments]    ${seq_no}    ${guids}
    ${resp}    auth_person_Post    ${seq_no}    ${guids}
    Should Be True    ${resp}[code]==1
    Should Not Be Empty    ${resp}[msg]
