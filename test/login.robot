*** Settings ***
Documentation       Test collection for registration system
Resource            ../resources/common.resource

*** Test Cases ***
TC1 Login a registered user with valid credentials
    [Documentation]         verifies that a registered user can login into the system with valid credentials
    [Tags]                  smoke
    Register a user         Setup payload data
    ...                     test_data=user     key=valid_user_1
    Login a user            Setup payload data
    ...                     test_data=login     key=valid_login_1
    verify status code      expected_status_code=200        actual_status_code=${RESPONSE.status_code}
    [Teardown]              Delete a user    user_name=john-test

TC2 Login a registered user without providing email address
    [Documentation]         verifies that a registered user cannot login into the system without providing a valid email
    [Tags]                  debug
    Register a user         Setup payload data
    ...                     test_data=user     key=valid_user_1
    Login a user            Setup payload data
    ...                     test_data=login     key=no_email_login
    verify status code      expected_status_code=403        actual_status_code=${RESPONSE.status_code}
    [Teardown]              Delete a user    user_name=john-test

TC3 Login a registered user without providing password
    [Documentation]         verifies that a registered user cannot login into the system without providing a valid password
    [Tags]                  debug1
    Register a user         Setup payload data
    ...                     test_data=user     key=valid_user_1
    Login a user            Setup payload data
    ...                     test_data=login     key=no_pwd_login
    verify status code      expected_status_code=403        actual_status_code=${RESPONSE.status_code}
    [Teardown]              Delete a user    user_name=john-test

TC4 Login a registered user with wrong email
    [Documentation]         verifies that a registered user cannot login into the system without providing a valid email
    [Tags]                  debug2
    Register a user         Setup payload data
    ...                     test_data=user     key=valid_user_1
    Login a user            Setup payload data
    ...                     test_data=login     key=wrong_email
    verify status code      expected_status_code=403        actual_status_code=${RESPONSE.status_code}
    [Teardown]              Delete a user    user_name=john-test

TC5 Login a registered user with wrong password
    [Documentation]         verifies that a registered user cannot login into the system without providing a valid password
    [Tags]                  debug3
    Register a user         Setup payload data
    ...                     test_data=user     key=valid_user_1
    Login a user            Setup payload data
    ...                     test_data=login     key=wrong_pwd
    verify status code      expected_status_code=403        actual_status_code=${RESPONSE.status_code}
    [Teardown]              Delete a user    user_name=john-test

