*** Settings ***
Documentation       Test collection for registration system
Resource            ../resources/common.resource

*** Test Cases ***
TC1 Register a user with valid credentials
    [Documentation]     verifies that user can register into the system with valid credentials
    [Tags]              smoke
    Register a user   Setup payload data
    ...      test_data=user     key=valid_user_1
    verify status code        expected_status_code=201        actual_status_code=${RESPONSE.status_code}
    [Teardown]        Delete a user    user_name=john-test

TC2 Register a user an with invalid email
    [Documentation]     verifies that user cannot register into the system with invalid email address
    [Tags]              email
    Register a user     Setup payload data
    ...                 test_data=user     key=invalid_email
    verify status code        expected_status_code=400        actual_status_code=${RESPONSE.status_code}
    [Teardown]        Delete a user    user_name=john-test

TC3 Register a user with no email
    [Documentation]     verifies that user cannot register into the system without providing an email address
    [Tags]              noemail
    Register a user     Setup payload data
    ...                 test_data=user     key=no_email
    verify status code        expected_status_code=400        actual_status_code=${RESPONSE.status_code}
    [Teardown]        Delete a user    user_name=john-test

TC4 Register a user with no First Name
    [Documentation]     verifies that user cannot register into the system without providing a first name
    [Tags]              nofn
    Register a user     Setup payload data
    ...                 test_data=user     key=no_first_name
    verify status code        expected_status_code=400        actual_status_code=${RESPONSE.status_code}
    [Teardown]        Delete a user    user_name=john-test

TC5 Register a user with password different from confirm password
    [Documentation]     verifies that user cannot register into the system when password is different from confirm
    ...                  password
    [Tags]              diffpwd
    Register a user     Setup payload data
    ...                 test_data=user     key=diff_confirm_pwd
    verify status code        expected_status_code=400        actual_status_code=${RESPONSE.status_code}
    [Teardown]        Delete a user    user_name=john-test

TC6 Register a user with sex other than male or female
    [Documentation]     verifies that user cannot register into the system when sex is neither male nor female
    [Tags]              diffsex
    Register a user     Setup payload data
    ...                 test_data=user     key=other_sex
    verify status code        expected_status_code=400        actual_status_code=${RESPONSE.status_code}
    [Teardown]        Delete a user    user_name=john-test

TC7 Register a user without providing sex
    [Documentation]     verifies that user cannot register into the system when sex is not provided
    [Tags]              nosex
    Register a user     Setup payload data
    ...                 test_data=user     key=no_sex
    verify status code        expected_status_code=400        actual_status_code=${RESPONSE.status_code}
    [Teardown]        Delete a user    user_name=john-test

TC8 Register a user without providing password and confirm password
    [Documentation]     verifies that user cannot register into the system without
    ...                 providing password and confirm password
    [Tags]              nopwds
    Register a user     Setup payload data
    ...                 test_data=user     key=no_pwd_and_conf_pwd
    verify status code        expected_status_code=400        actual_status_code=${RESPONSE.status_code}
    [Teardown]        Delete a user    user_name=john-test

TC9 Register a user without providing confirm password
    [Documentation]     verifies that user cannot register into the system without
    ...                 providing confirm password
    [Tags]              confpwd
    Register a user     Setup payload data
    ...                 test_data=user     key=no_conf_pwd
    verify status code        expected_status_code=400        actual_status_code=${RESPONSE.status_code}
    [Teardown]        Delete a user    user_name=john-test

TC10 Register a user without providing password
     [Documentation]     verifies that user cannot register into the system without providing password
     [Tags]              nopwd
     Register a user     Setup payload data
     ...                 test_data=user     key=no_pwd
     verify status code        expected_status_code=400        actual_status_code=${RESPONSE.status_code}
     [Teardown]        Delete a user    user_name=john-test


TC11 Register 2 users with the same username
     [Documentation]     verifies that  2 users cannot be registered into the system with the same username
     [Tags]              user
     Register a user     Setup payload data
     ...                 test_data=user     key=same_username_1
     Register a user     Setup payload data
     ...                 test_data=user     key=same_username_2
     verify status code        expected_status_code=400        actual_status_code=${RESPONSE.status_code}
     [Teardown]        Delete a user    user_name=john-test

TC12 Register 2 users with the same email address
     [Documentation]     verifies that  2 users cannot be registered into the system with the same email address
     [Tags]              sameemail
     Register a user     Setup payload data
     ...                 test_data=user     key=same_email_1
     Register a user     Setup payload data
     ...                 test_data=user     key=same_email_2
     verify status code        expected_status_code=400        actual_status_code=${RESPONSE.status_code}
     [Teardown]        Delete a user    user_name=john-test







