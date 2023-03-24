*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite
Library                        QVision

*** Test Cases ***
Create Opportunity
    Appstate     Home
    ClickText    Opportunities
    ClickText    new
    UseModal     on
    ComboBox     Search Accounts...    Larry 2023
    Type text     *Opportunity Name    Hillfoure's Farms
    TypeText      Amount               30000
    TypeText      *Close Date          3/31/2023
    PickList      *Stage               Proposal
    ClickText     Save                 partial_match=False
    UseModal      off
    