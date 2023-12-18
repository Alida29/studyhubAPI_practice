*** Settings ***
Documentation       Test collection for question functionality
Resource            ../resources/common.resource

*** Test Cases ***
TC1 Ask a question when signed in
    [Documentation]     verifies that user can ask a question when signed into the system
    [Tags]              smoke
    ${payload}        Setup payload data
    ...               test_data=question
    ...               key=valid_question
    ${auth_id}      Prepare user for question
    ...             user=valid_user_1       email=johntester@gmail.com      password=password1234
    ${prepare_auth}     Create Dictionary
    ...                 auth_id=${auth_id}
    ${payload}        Setup payload data
    ...               test_data=question
    ...               key=valid_question
    post request      url=https://study-hub-backend.onrender.com/questions
    ...               payload=${payload}
    ...               auth=${prepare_auth}
    verify status code        expected_status_code=201        actual_status_code=${RESPONSE.status_code}
    ${question_info}=      Convert Json to Dictionary        ${RESPONSE.text}
    [Teardown]      Run Keywords
    ...          Delete a question
    ...          question_id=${question['question_id']}
    ...          auth_id=${auth_id}         AND
    ...          Delete a user          user_name=john-test