*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    Chrome
${JUSTVAR1}   helloworld
${URL}        http://the-internet.herokuapp.com/login
${USERNAME1}   tomsmith
${USERNAME2}   tomholland
${PASSWORD1}   SuperSecretPassword!
${PASSWORD2}   Password!
${LOGIN BUTTON}    xpath://i[contains(text(), 'Login')]
${LOGOUT BUTTON}    xpath://i[contains(text(), ' Logout')]
${LOGIN SUCCESS MESSAGE}    You logged into a secure area!
${USERNAME INVALID}    Your username is invalid!
${PASSWORD INVALID}    Your password is invalid!
${LOGOUT SUCCESS MESSAGE}    You logged out of the secure area!

*** Test Cases ***
Login success
    Open Browser    ${URL}    ${BROWSER}
    Input Text      id=username    ${USERNAME1}
    Input Text      id=password    ${PASSWORD1}
    Click Element   ${LOGIN BUTTON}
    Wait For Text    id=flash    ${LOGIN SUCCESS MESSAGE}
    Click Element   ${LOGOUT BUTTON}
    Wait For Text    id=flash    ${LOGOUT SUCCESS MESSAGE}

Login failed - Password incorrect
    # Open Browser    ${URL}    ${BROWSER}
    Input Text      id=username    ${USERNAME1}
    Input Text      id=password    ${PASSWORD2}
    Click Element   ${LOGIN BUTTON}
    Wait For Text    id=flash    ${PASSWORD INVALID}

Login failed - Username not found
    # Open Browser    ${URL}    ${BROWSER}
    Input Text      id=username    ${USERNAME2}
    Input Text      id=password    ${PASSWORD2}
    Click Element   ${LOGIN BUTTON}
    Wait For Text    id=flash    ${USERNAME INVALID}

*** Keywords ***
Wait For Text
    [Arguments]    ${locator}    ${expected_text}
    Wait Until Element Contains    ${locator}    ${expected_text}