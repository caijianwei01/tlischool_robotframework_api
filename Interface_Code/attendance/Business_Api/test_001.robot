*** Settings ***
Resource          ../../../Resources/Public/http_request.robot

*** Test Cases ***
test
    ${dict1}    Create Dictionary    a=1    b=2
    ${dict2}    Create Dictionary    c=3    d=4
    add_header    ${dict1}    ${dict2}
    log    ${dict2}

test001
    ${cookies}    Set Variable    None
    ${cookie_dict}    Create Dictionary    d=4
    add_cookie    ${cookies}    ${cookie_dict}
    log    ${cookie_dict}
