*** Settings ***
Resource          ../../../../Resources/Business/attendance.robot

*** Test Cases ***

*** Keywords ***
device_auth_person_query_Get
    [Arguments]    ${name}
    ${datas}    Create Dictionary
    ${headers}    Create Dictionary
    ${token}    get_token
    Set To Dictionary    ${datas}    name=${name}
    Set To Dictionary    ${headers}    token=${token}
    ${resp}    request_get    ${URL}    ${DEVICE_INTERACTIVE}
