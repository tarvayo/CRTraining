*** Settings ***
Library                         QWeb
Library                         QForce
Library                         String
Library                         DateTime


*** Variables ***
${BROWSER}                      chrome
${username}                     tristan.arvayo-1z0h@force.com
${login_url}                    https://xyz239.lightning.force.com                      # Salesforce instance. NOTE: Should be overwritten in CRT variables
${home_url}                     ${login_url}/lightning/page/home


*** Keywords ***
Setup Browser
    Set Library Search Order    QWeb                        QForce
    Open Browser                about:blank                 ${BROWSER}
    SetConfig                   LineBreak                   ${EMPTY}                    #\ue000
    SetConfig                   DefaultTimeout              20s                         #sometimes salesforce is slow


End suite
    Set Library Search Order    QWeb                        QForce
    Close All Browsers


Login
    [Documentation]             Login to Salesforce instance
    Set Library Search Order    QWeb                        QForce
    GoTo                        ${login_url}
    TypeText                    Username                    ${username}                 delay=1
    TypeText                    Password                    ${password}
    ClickText                   Log In


Home
    [Documentation]             Navigate to homepage, login if needed
    Set Library Search Order    QWeb                        QForce
    GoTo                        ${home_url}
    ${login_status} =           IsText                      To access this page, you have to log in to Salesforce.    2
    Run Keyword If              ${login_status}             Login
    ClickText                   Home
    VerifyTitle                 Home | Salesforce

Create Account
    [Documentation]             This test creates an account to make sure account creation is working properly.
    [Arguments]                 ${Name}    ${NumOfEmployees}
    Login
    ${currentyear}              Get Current Date            result_format=%Y
    ${AccName}                  Catenate                    ${Name}                     ${currentyear}
    ClickText                   Accounts
    ClickText                   New
    UseModal                    On
    TypeText                    *Account Name               ${AccName}
    TypeText                    Phone                       +1 2345671234
    TypeText                    Website                     www.wesbsite.com
    TypeText                    Employees                   ${NumOfEmployees}
    PickList                    Industry                    Energy
    PickList                    Type                        Other
    ClickText                   Save                        partial_match=false
    UseModal                    Off
    ClickText                   Details