*** Settings ***
Documentation       Test collection for registration system
Resource            ../resources/common.resource

*** Test Cases ***
TC1 Register with valid credentials
    [Documentation]     verifies that user can register into the system with valid credentials
    [Tags]              smoke
    Register a user   Setup payload data
    ...      test_data=user     key=valid_user_1
    verify status code        expected_status_code=201        actual_status_code=${RESPONSE.status_code}
    [Teardown]        Delete a user    user_name=john-test
