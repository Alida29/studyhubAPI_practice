*** Settings ***
Documentation       Keywords collection for all test cases
Library             Hook.py


*** Keywords ***
Setup payload data
    [Arguments]     ${test_data}        ${key}
    &{payload}      prepare payload
    ...             test_data/${test_data}/${test_data}_data.json
    ...             ${key}
    [Return]        ${payload}

Delete a user
    [Arguments]     ${user_name}
    ${prepare_dict}     Create Dictionary
    ...                 user_name=${user_name}
    delete request
     ...             url=https://study-hub-backend.onrender.com/deleteuser
     ...             dict_data=${prepare_dict}

Delete a question
    [Arguments]     ${question_id}      ${auth_id}
    ${prepare_auth}     Create Dictionary
    ...                 auth_id=${auth_id}
    delete request
     ...             url=https://study-hub-backend.onrender.com/question/${question_id}
     ...             dict_data=${prepare_auth}
     
Prepare user for question
    [Arguments]     ${user}     ${email}    ${password}
    ${payload}        Setup payload data
    ...               test_data=user
    ...               key=${user}
    post request      url=https://study-hub-backend.onrender.com/register
    ...               payload=${payload}
    ${auth_id}        Prepare authorization   ${email}        ${password}
    [Return]             ${auth_id}
      
Prepare authorization
    [Arguments]             ${email}        ${password}
    ${prepare_dict}     Create Dictionary
    ...                 email=${email}
    ...                 pwdhash=${password}
    post request      url=https://study-hub-backend.onrender.com/login
      ...               payload=${prepare_dict}
    ${auth_user_info}=      Convert Json to Dictionary        ${RESPONSE.text}
    [Return]                 ${auth_user_info[0]['auth_id']}

Register a user
    [Arguments]       ${payload}        ${test_data}        ${key}
    ${payload}        Setup payload data
    ...               test_data=${test_data}
    ...               key=${key}
    post request      url=https://study-hub-backend.onrender.com/register
    ...               payload=${payload}

Login a user
    [Arguments]       ${payload}    ${test_data}        ${key}
    ${payload}        Setup payload data
    ...               test_data=${test_data}
    ...               key=${key}
    post request      url=https://study-hub-backend.onrender.com/login
    ...               payload=${payload}




    
