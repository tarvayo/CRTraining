*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite
Library                        QVision

*** Test Cases ***
Create Opportunity
    Appstate Home